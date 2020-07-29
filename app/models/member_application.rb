class MemberApplication < ApplicationRecord
  has_one_attached :psych_eval
  has_one_attached :psych_social
  has_one_attached :insurance_card

  validates :psych_eval, :psych_social, :insurance_card,
    attached: true,
    content_type: ["application/pdf",
                   "application/msword",
                   "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                   "image/jpeg"]

  validates :ssn, format: { with: /\A[0-9]{9}\z/,
    message: "must be a 9 digit number" }

  validates :first_name, :last_name, :dob, :place_of_birth, :age, :ssn, :gender,
    :street_address, :city, :state, :zip_code, :phone_number,
    :residence_time_length, :recommend_name, :recommend_agency,
    :recommend_phone_number, :recommend_known_length, :tour_fh, :total_income,
    :hospitalization_count, :bronx_or_manhattan, :member_signature,
    :referral_signature, :wanted_reduce_substance_use,
    :been_annoyed_by_substance_criticism, :felt_bad_about_substance_use,
    :ever_used_substances_for_hangover, presence: true
end
