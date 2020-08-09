class CreateMemberApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :member_applications, id: :uuid do |t|
      [
        :ssn, :first_name, :last_name, :mi, :dob, :age,
        :gender, :street_address, :apt, :city, :state, :zip_code,
        :phone_number, :county, :residence_time_length, :email_address,
        :recommend_name, :recommend_agency, :recommend_phone_number,
        :recommend_agency_type, :recommend_known_length,
        :who_live_with,
        :ssi, :family_income, :veteran_benefits, :ssdi, :snap,
        :public_assistance, :wages, :retirement_benefits, :other_income,
        :total_income, :recommend_email, :other_language,
        :school_attended_1, :school_years_1, :major_1, :graduate_1,
        :school_attended_2, :school_years_2, :major_2, :graduate_2,
        :school_attended_3, :school_years_3, :major_3, :graduate_3,
        :employer_1,
        :work_title_1, :employer_2, :employer_3, :employer_4, :employer_5,
        :work_type_1,
        :work_title_2, :work_type_2, :work_title_3, :work_type_3, :work_title_4,
        :work_type_4, :work_title_5, :work_type_5, :med_alert_other,
        :psych_seeing_length, :psych_email, :therapist_seeing_length,
        :therapist_email, :primary_care_email, :emerg_primary_name,
        :emerg_primary_phone, :emerg_primary_relation, :emerg_secondary_name,
        :emerg_secondary_phone, :emerg_secondary_relation, :medicaid_comp,
        :psych_name, :psych_agency, :psych_phone, :psych_address, :therapist_name,
        :therapist_agency, :therapist_phone, :therapist_address,
        :primary_care_address, :primary_care_name, :primary_care_agency,
        :primary_care_phone, :insurance_num,
        :hospitalization_count, :past_treatment_when_and_where,
        :current_treatment_when_and_where, :hospital_name_1,
        :hospital_name_2,
        :hospital_name_3,
        :hospital_name_4,
        :hospital_name_5,
        :hospital_name_6,
        :hospital_name_7,
        :hospital_name_8,
        :hospital_name_9,
        :hospital_name_10,
        :bronx_or_manhattan, :member_signature,
        :insurance_other, :wanted_reduce_substance_use,
        :been_annoyed_by_substance_criticism, :felt_bad_about_substance_use,
        :ever_used_substances_for_hangover, :been_in_jail, :been_in_prison,
        :convicted_of_misdemeanor, :arrests_for_felonies, :injured_another_person,
        :history_of_violence, :med_name_1, :med_name_2, :med_name_3, :med_name_4,
        :med_name_5, :med_name_6, :med_dosage_1, :med_dosage_2, :med_dosage_3,
        :med_dosage_4, :med_dosage_5, :med_dosage_6, :med_freq_1, :med_freq_2,
        :med_freq_3, :med_freq_4, :med_freq_5, :med_freq_6, :place_of_birth,
        :main_goal_other_text, :what_challenges,
        :children_number, :other_sup_text, :referral_signature, :tour_fh,
        :us_citizen, :recommend_type, :main_goal, :current_housing_type,
        :live_alone_or_with_others, :reside_with_minors, :acs_involvement,
        :have_homeless_history, :marital_status, :have_children,
        :are_you_veteran, :get_needs_met, :feel_part, :ever_worked,
        :worked_last_12_months, :insurance_name, :harp, :hcbs,
        :abuse_history_alcohol, :abuse_history_drugs, :ever_in_treatment,
        :currently_in_treatment, :interested_in_treatment
      ].each do |name|
        t.string name
      end

      [
        :homeless_explanation, :work_notes, :med_alert_memo, :dsm_v,
        :hosp_precip_1, :hosp_precip_2, :hosp_precip_3, :hosp_precip_4,
        :hosp_precip_5, :hosp_precip_6, :hosp_precip_7, :hosp_precip_8,
        :hosp_precip_9, :hosp_precip_10, :abuse_history_elaboration,
        :legal_history_detail
      ].each do |name|
        t.text name
      end

      [
        :eth_other, :eth_aa, :eth_asian, :eth_na, :eth_aa_ac, :eth_aa_other,
        :eth_aa_unknown, :eth_aa_na, :eth_cuban, :eth_mex, :eth_pr, :eth_dom,
        :eth_sa, :eth_ca,
        :eth_cauc, :eth_pi, :eth_car, :less_hs, :trade_school, :some_grad_work,
        :some_hs, :some_college, :masters_degree, :ged, :assoc_degree,
        :adv_grad_degree, :hs_diploma, :bachelors_degree, :med_alert_deaf,
        :med_alert_recent_surg, :med_alert_asthma, :med_alert_diabetes,
        :med_alert_cpi, :med_alert_npm, :med_alert_ep, :med_alert_allerg,
        :med_alert_blind, :med_alert_hyper, :sub_abuse_check, :work_prog_check,
        :acces_vr_check, :edu_sup_check, :act_team_check, :application_status
      ].each do |name|
        t.integer name
      end

      [
        :tour_date, :work_start_date_1, :work_end_date_1, :work_start_date_2, :work_end_date_2,
        :work_start_date_3, :work_end_date_3, :work_start_date_4,
        :work_end_date_4, :work_start_date_5, :work_end_date_5, :last_physical_exam_date,
        :last_dental_exam_date, :hospital_start_date_1, :hospital_end_date_1,
        :hospital_start_date_2, :hospital_end_date_2, :hospital_start_date_3, :hospital_end_date_3,
        :hospital_start_date_4, :hospital_end_date_4, :hospital_start_date_5, :hospital_end_date_5,
        :hospital_start_date_6, :hospital_end_date_6, :hospital_start_date_7, :hospital_end_date_7,
        :hospital_start_date_8, :hospital_end_date_8, :hospital_start_date_9, :hospital_end_date_9,
        :hospital_start_date_10, :hospital_end_date_10,
        :referral_signature_date, :member_signature_date,
        :application_expiration_date
      ].each do |name|
        t.date name
      end

      t.timestamps
    end
  end
end
