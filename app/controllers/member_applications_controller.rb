class MemberApplicationsController < ApplicationController
  FILE_TYPE_WHITELIST = ["application/pdf",
                         "application/msword",
                         "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                         "image/jpeg",
                         "image/png"].freeze

  def new
    render :new, locals: { member_application: MemberApplication.new }
  end

  def create
    @member_application = MemberApplication.new(member_application_params)

    if params[:commit] == "Submit Application"
      if file_types_valid? && member_application.update(application_status: "submitted")
        member_application.finalize!
        flash[:success] = "Your application was submitted successfully"
        redirect_to member_application_path(member_application)
      else
        member_application.application_status = "draft"
        flash.now[:error] = member_application.errors.full_messages.to_sentence
        render :new, locals: { member_application: member_application }
      end
    elsif file_types_valid? && member_application.save
      flash[:notice] = "Application created successfully"
      redirect_to edit_member_application_path(member_application)
    else
      flash.now[:error] = member_application.errors.full_messages.to_sentence
      render :new, locals: { member_application: member_application }
    end
  end

  def edit
    if member_application.draft?
      flash.now[:secondary] = "You can return to this form until #{member_application.application_expiration_date.strftime("%b %d, %Y")} and continue filling it out by bookmarking the current page or copying this URL:<br />#{view_context.link_to("#{edit_member_application_url(member_application)}", edit_member_application_url(member_application))}"
      render :edit, locals: { member_application: member_application }
    else
      redirect_to member_application_path(member_application)
    end
  end

  def show
    if member_application.draft?
      redirect_to edit_member_application_path(member_application)
    else
      flash.now[:notice] = "This application has been submitted and can no longer be edited."
      flash.now[:secondary] = "You can access this application until #{member_application.application_expiration_date.strftime("%b %d, %Y")}."
      render :show, locals: { member_application: member_application }
    end
  end

  def update
    if member_application.submitted?
      flash[:error] = "You cannot update an application once it's submitted"
      redirect_to member_application_path(member_application) and return
    end

    if params[:commit] == "Submit Application"
      if file_types_valid? && member_application.update(member_application_params.merge(application_status: "submitted"))
        member_application.finalize!
        flash[:success] = "Your application was submitted successfully"
        redirect_to member_application_path(member_application)
      else
        member_application.reload
        flash.now[:error] = member_application.errors.full_messages.to_sentence
        render :edit, locals: { member_application: member_application }
      end
    elsif file_types_valid? && member_application.update(member_application_params)
      flash[:notice] = "Application updated successfully."
      redirect_to edit_member_application_path(member_application)
    else
      flash.now[:error] = member_application.errors.full_messages.to_sentence
      render :edit, locals: { member_application: member_application }
    end
  end

  def pdf
    grover = Grover.new("#{request.base_url}/member_applications/#{member_application.id}")
    send_data(grover.to_pdf, filename: "#{member_application.first_name}_#{member_application.last_name}_#{member_application.id}.pdf", type: "application/pdf")
  end

  private

  def member_application
    @member_application ||= MemberApplication.find(params.require(:id))
  end

  def attachment_file_type(attachment_name)
    line = Terrapin::CommandLine.new("file", "-b --mime-type :filename")
    line.run(filename: params["member_application"][attachment_name].tempfile.path).chomp
  end

  def file_types_valid?
    ["psych_eval", "psych_social", "insurance_card"].each do |attachment_name|
      next if params["member_application"][attachment_name].blank?
      unless FILE_TYPE_WHITELIST.include?(attachment_file_type(attachment_name))
        member_application.errors.add(attachment_name, "must be an accepted file type (.pdf, .doc, .docx, .jpg, .png)")
      end
    end
    member_application.errors.none?
  end

  def member_application_params
    params.require(:member_application).permit(
      :psych_social, :psych_eval, :insurance_card,
      :ssn, :first_name, :last_name, :mi, :dob, :age, :gender, :street_address,
      :apt, :city, :state, :zip_code, :phone_number_landline, :phone_number_cell, :county, :residence_time_length,
      :email_address, :recommend_name, :recommend_agency, :recommend_phone_number,
      :recommend_agency_type, :recommend_known_length, :who_live_with, :ssi, :family_income,
      :veteran_benefits, :ssdi, :snap, :public_assistance, :wages, :retirement_benefits,
      :other_income, :total_income, :recommend_email, :other_language, :med_alert_other,
      :psych_seeing_length, :psych_email, :therapist_seeing_length, :therapist_email,
      :primary_care_email, :emerg_primary_name, :emerg_primary_phone, :emerg_primary_relation,
      :emerg_secondary_name, :emerg_secondary_phone, :emerg_secondary_relation,
      :medicaid_comp, :psych_name, :psych_agency, :psych_phone, :psych_address,
      :therapist_name, :therapist_agency, :therapist_phone, :therapist_address,
      :primary_care_address, :primary_care_name, :primary_care_agency, :primary_care_phone,
      :insurance_num, :hospitalization_count, :past_treatment_when_and_where,
      :current_treatment_when_and_where, :bronx_or_manhattan, :member_signature,
      :insurance_other, :wanted_reduce_substance_use, :been_annoyed_by_substance_criticism,
      :felt_bad_about_substance_use, :ever_used_substances_for_hangover,
      :been_in_jail, :been_in_prison, :convicted_of_misdemeanor, :injured_another_person,
      :history_of_violence, :med_name_1, :med_name_2, :med_name_3, :med_name_4,
      :med_name_5, :med_name_6, :med_dosage_1, :med_dosage_2, :med_dosage_3,
      :med_dosage_4, :med_dosage_5, :med_dosage_6, :med_freq_1, :med_freq_2,
      :med_freq_3, :med_freq_4, :med_freq_5, :med_freq_6, :main_goal_other_text,
      :what_challenges, :children_number, :referral_signature, :tour_fh, :us_citizen,
      :main_goal, :current_housing_type, :live_alone_or_with_others, :reside_with_minors,
      :acs_involvement, :have_homeless_history, :marital_status, :have_children,
      :are_you_veteran, :get_needs_met, :feel_part, :ever_worked, :worked_last_12_months,
      :insurance_name, :harp, :hcbs, :abuse_history_alcohol, :abuse_history_drugs,
      :ever_in_treatment, :currently_in_treatment, :interested_in_treatment,
      :homeless_explanation, :med_alert_memo, :dsm_v, :legal_history_detail,
      :eth_aa, :eth_na, :eth_aa_ac, :eth_cuban, :eth_mex, :eth_pr, :eth_dom,
      :eth_sa, :eth_ca, :eth_pi, :less_hs, :trade_school, :some_grad_work,
      :some_hs, :some_college, :masters_degree, :ged, :assoc_degree,
      :adv_grad_degree, :hs_diploma, :bachelors_degree, :med_alert_deaf,
      :med_alert_recent_surg, :med_alert_asthma, :med_alert_diabetes, :med_alert_cpi,
      :med_alert_npm, :med_alert_ep, :med_alert_allerg, :med_alert_blind, :med_alert_hyper,
      :application_status, :tour_date, :last_physical_exam_date, :last_dental_exam_date,
      :referral_signature_date, :member_signature_date, :application_expiration_date,
      :satisfaction_physical_health, :satisfaction_mood, :satisfaction_work,
      :satisfaction_household, :satisfaction_social, :satisfaction_family,
      :satisfaction_leisure, :satisfaction_function, :satisfaction_economic,
      :satisfaction_living_sit, :satisfaction_get_around, :satisfaction_vision,
      :satisfaction_overall_sense, :satisfaction_medication, :satisfaction_overall_life,
      :hospital_recent_name, :hospital_first_name, :housing_agency_program_name,
      :currently_employed, :num_years_of_work, :currently_tobacco, :history_tobacco,
      :convicted_of_felony, :lack_companion, :left_out, :feel_isolated, :why_fh_good_place,
      :hospital_recent_start_date, :hospital_recent_end_date, :hospital_first_start_date,
      :hospital_first_end_date, :eth_aa_carrib, :eth_black_other, :eth_asian_fe,
      :eth_asian_se, :eth_asian_is, :eth_white_na, :eth_white_me, :eth_white_amer,
      :eth_white_eu, :eth_white_other, :clubhouse_id
    )
  end
end
