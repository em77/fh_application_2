class MemberApplication < ApplicationRecord
  belongs_to :clubhouse, optional: true

  has_one_attached :psych_eval
  has_one_attached :psych_social
  has_one_attached :insurance_card

  enum application_status: [:draft, :submitted]

  validates :psych_eval, :psych_social, :insurance_card,
    attached: true, unless: :is_draft?

  validates :ssn, format: { with: /\A[0-9]{9}\z/,
    message: "must be a 9 digit number" }, unless: :is_draft?

  validate :phone_numbers

  validates :age, format: { with: /\A(1[89]|[2-9][0-9]|1[0-3][0-9]|140)\z/,
    message: "must be 18 or older to apply (adjust Date of Birth to change)" }, unless: :is_draft?

  validate :phone_numbers, unless: :is_draft?

  validates :first_name, :last_name, :dob, :age, :ssn, :gender,
    :street_address, :city, :state, :zip_code,
    :residence_time_length, :recommend_name, :recommend_agency,
    :recommend_phone_number, :recommend_agency_type,
    :recommend_known_length, :tour_fh, :total_income,
    :hospitalization_count, :member_signature,
    :referral_signature, :current_housing_type,
    :live_alone_or_with_others, :have_homeless_history, :reside_with_minors,
    :marital_status, :have_children, :are_you_veteran, :us_citizen,
    :get_needs_met, :feel_part, :currently_employed, :ever_worked,
    :worked_last_12_months, :num_years_of_work, :insurance_name,
    :harp, :hcbs, :last_physical_exam_date, :dsm_v, :currently_tobacco,
    :history_tobacco, :abuse_history_alcohol, :abuse_history_drugs,
    :ever_in_treatment, :currently_in_treatment, :been_in_jail,
    :been_in_prison, :convicted_of_misdemeanor, :convicted_of_felony,
    :injured_another_person, :history_of_violence, :get_needs_met,
    :feel_part, :lack_companion, :left_out, :feel_isolated, :satisfaction_physical_health,
    :satisfaction_mood, :satisfaction_work, :satisfaction_household, :satisfaction_social,
    :satisfaction_family, :satisfaction_leisure, :satisfaction_function, :satisfaction_economic,
    :satisfaction_living_sit, :satisfaction_get_around, :satisfaction_vision,
    :satisfaction_overall_sense, :satisfaction_medication, :satisfaction_overall_life,
    :wanted_reduce_substance_use, :been_annoyed_by_substance_criticism,
    :felt_bad_about_substance_use, :ever_used_substances_for_hangover, presence: true, unless: :is_draft?

  validates_presence_of :clubhouse, message: "Please select what organization you are applying to in the Signature section",
    unless: :old_org_choice_is_present?

  before_save :update_expiration!
  before_save :migrate_to_using_clubhouses
  after_create :send_edit_application_notification_email, if: :is_draft?

  def is_draft?
    self.draft?
  end

  def send_edit_application_notification_email
    member_and_recommender_emails.each { |email| MemberApplicationMailer.edit_application_notification(self, email).deliver_later }
  end

  def finalize!
    self.update(
      referral_signature_date: today,
      member_signature_date: today,
      application_expiration_date: today + 60.days,
      phone_number_landline_type: twilio_phone_number_type(self.phone_number_landline),
      phone_number_cell_type: twilio_phone_number_type(self.phone_number_cell)
    )
    ApplicationLog.create
    MemberApplicationMailer.new_member_application(self).deliver_now
    member_and_recommender_emails.each { |email| MemberApplicationMailer.submitted_application_notification(self, email).deliver_later}
  end

  def member_and_recommender_emails
    [self.email_address, self.recommend_email].reject(&:blank?)
  end

  def twilio_phone_number_type(phone_number)
    return "unknown" if phone_number.blank?
    client = Twilio::REST::Client.new(Rails.application.credentials.dig(:twilio, :account_sid), Rails.application.credentials.dig(:twilio, :auth_token))
    begin
      number = client.lookups
                     .phone_numbers("+1#{phone_number.gsub('-', '')}")
                     .fetch(type: ['carrier'])
      number.try(:carrier).try(:[], 'type') || "unknown"
    rescue Twilio::REST::RestError
      "unknown"
    end
  end

  def update_expiration!
    self.application_expiration_date = today + 60.days
  end

  private

  def phone_numbers
    if self.phone_number_landline.blank? && self.phone_number_cell.blank?
      errors.add(:base, "Either Phone number (landline) or Phone number (cell) must be entered")
      return
    end

    [:phone_number_landline, :phone_number_cell].each do |attribute|
      next if self.send(attribute).blank?
      unless self.send(attribute).match?(/\A[0-9]{3}-[0-9]{3}-[0-9]{4}\z/)
        errors.add(attribute, "must be a 10 digit phone number (example: 555-666-7777)")
      end
    end
  end

  def today
    Time.current.in_time_zone("Eastern Time (US & Canada)").to_date
  end

  def migrate_to_using_clubhouses
    return unless self.bronx_or_manhattan.present? && self.clubhouse.blank?

    found_clubhouse = Clubhouse.find_by_name("Fountain House - #{self.bronx_or_manhattan}")
    self.clubhouse = found_clubhouse
  end

  def old_org_choice_is_present?
    self.bronx_or_manhattan.present? || is_draft?
  end
end
