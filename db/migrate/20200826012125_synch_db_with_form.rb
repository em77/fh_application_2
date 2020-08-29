class SynchDbWithForm < ActiveRecord::Migration[6.0]
  def change
    [
      :place_of_birth, :recommend_type, :school_attended_1, :school_years_1,
      :major_1, :graduate_1, :school_attended_2, :school_years_2, :major_2,
      :graduate_2, :school_attended_3, :school_years_3, :major_3, :graduate_3,
      :employer_1, :employer_2, :employer_3, :employer_4, :employer_5,
      :work_title_1, :work_title_2, :work_title_3, :work_title_4, :work_title_5,
      :work_type_1, :work_type_2, :work_type_3, :work_type_4, :work_type_5,
      :arrests_for_felonies, :other_sup_text, :hospital_name_1, :hospital_name_2,
      :hospital_name_3, :hospital_name_4, :hospital_name_5, :hospital_name_6,
      :hospital_name_7, :hospital_name_8, :hospital_name_9, :hospital_name_10,
      :work_notes, :hosp_precip_1, :hosp_precip_2, :hosp_precip_3,
      :hosp_precip_4, :hosp_precip_5, :hosp_precip_6, :hosp_precip_7,
      :hosp_precip_8, :hosp_precip_9, :hosp_precip_10, :work_start_date_1,
      :work_start_date_2, :work_start_date_3, :work_start_date_4,
      :work_start_date_5, :work_end_date_1, :work_end_date_2, :work_end_date_3,
      :work_end_date_4, :work_end_date_5, :abuse_history_elaboration,
      :hospital_start_date_1, :hospital_start_date_2, :hospital_start_date_3,
      :hospital_start_date_4, :hospital_start_date_5, :hospital_start_date_6,
      :hospital_start_date_7, :hospital_start_date_8, :hospital_start_date_9,
      :hospital_start_date_10, :hospital_end_date_1, :hospital_end_date_2,
      :hospital_end_date_3, :hospital_end_date_4, :hospital_end_date_5,
      :hospital_end_date_6, :hospital_end_date_7, :hospital_end_date_8,
      :hospital_end_date_9, :hospital_end_date_10, :sub_abuse_check,
      :work_prog_check, :acces_vr_check, :edu_sup_check, :act_team_check,
      :eth_other, :eth_asian, :eth_aa_other,
      :eth_aa_unknown, :eth_aa_na, :eth_cauc, :eth_car
    ].each do |name|
      remove_column :member_applications, name
    end

    [
      :satisfaction_physical_health, :satisfaction_mood, :satisfaction_work,
      :satisfaction_household, :satisfaction_social, :satisfaction_family,
      :satisfaction_leisure, :satisfaction_function, :satisfaction_economic,
      :satisfaction_living_sit, :satisfaction_get_around, :satisfaction_vision,
      :satisfaction_overall_sense, :satisfaction_medication,
      :satisfaction_overall_life, :hospital_recent_name, :hospital_first_name,
      :housing_agency_program_name, :currently_employed, :num_years_of_work,
      :currently_tobacco, :history_tobacco, :convicted_of_felony,
      :lack_companion, :left_out, :feel_isolated
    ].each do |name|
      add_column :member_applications, name, :string
    end

    add_column :member_applications, :why_fh_good_place, :text
    
    [
      :hospital_recent_start_date, :hospital_recent_end_date,
      :hospital_first_start_date, :hospital_first_end_date
    ].each do |name|
      add_column :member_applications, name, :date
    end

    [
      :eth_aa_carrib, :eth_black_other, :eth_asian_fe, :eth_asian_se,
      :eth_asian_is, :eth_white_na, :eth_white_me, :eth_white_amer, :eth_white_eu,
      :eth_white_other
    ].each do |name|
      add_column :member_applications, name, :integer
    end
  end
end
