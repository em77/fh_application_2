module Features
  module AppSubmitHelper
    def fill_out_app(with_js = false)
      Faker::Config.locale = "en-US"

      fill_in :member_application_first_name, with: Faker::Name.first_name
      fill_in :member_application_last_name, with: Faker::Name.last_name
      fill_in :member_application_mi, with: "A"

      if with_js
        find_field("dob-field", type: :hidden).sibling("input").set(Faker::Date.between(from: 40.years.ago, to: 20.years.ago).strftime("%B %d, %Y"))
      else
        dob = Faker::Date.between(from: 40.years.ago, to: 20.years.ago).strftime("%B %d, %Y")
        fill_in "Date of Birth", with: dob
      end

      fill_in "SSN", with: Faker::Number.number(digits: 9)
      fill_in :member_application_gender, with: "Female"
      fill_in :member_application_apt, with: Faker::Address.secondary_address
      fill_in :member_application_city, with: Faker::Address.city
      fill_in :member_application_state, with: Faker::Address.state
      fill_in :member_application_zip_code, with: Faker::Address.zip
      fill_in :member_application_county, with: Faker::Address.city
      fill_in :member_application_residence_time_length, with: "#{rand(20)} years"

      fill_in :member_application_housing_agency_program_name, with: Faker::Company.buzzword

      if with_js
        find_field("member_application_tour_date", type: :hidden).sibling("input").set(Faker::Date.between(from: 1.years.ago, to: 10.days.ago).strftime("%B %d, %Y"))
      else
        fill_in "Date of tour", with: Faker::Date.between(from: 1.years.ago, to: 10.days.ago).strftime("%B %d, %Y")
      end

      select("Education", from: (:member_application_main_goal).to_s)

      select("Home of Family Member",
        from: (:member_application_current_housing_type).to_s)
      select("With others",
        from: (:member_application_live_alone_or_with_others).to_s)
      fill_in :member_application_who_live_with, with: "Parents"

      [:member_application_ssi, :member_application_ssdi, :member_application_wages, :member_application_family_income, :member_application_snap, :member_application_retirement_benefits,
        :member_application_veteran_benefits, :member_application_public_assistance, :member_application_other_income]
        . each {|n| fill_in n, with: rand(200)}

      select("Permanent Partner", from: (:member_application_marital_status).to_s)

      [:member_application_other_language, :member_application_med_name_1, :member_application_med_name_2, :member_application_med_name_3, :member_application_med_name_4,
        :member_application_med_name_5, :member_application_med_name_6, :member_application_med_dosage_1, :member_application_med_dosage_2, :member_application_med_dosage_3,
        :member_application_med_dosage_4, :member_application_med_dosage_5, :member_application_med_dosage_6, :member_application_med_freq_1, :member_application_med_freq_2,
        :member_application_med_freq_3, :member_application_med_freq_4, :member_application_med_freq_5, :member_application_med_freq_6]
        .each do |n|
        fill_in n, with: Faker::Lorem.word
      end

      if with_js
        ["member_application_last_physical_exam_date", "member_application_last_dental_exam_date", "member_application_hospital_first_start_date",
          "member_application_hospital_first_end_date", "member_application_hospital_recent_start_date", "member_application_hospital_recent_end_date"]
          .each do |id|
            find_field(id, type: :hidden).sibling("input").set(Faker::Date.between(from: 15.years.ago, to: Date.today).strftime("%B %d, %Y"))
          end
      else
        ["Date of last physical exam", "Date of last dental exam", "Approx. End Date (Recent)",
        "Approx. Start Date (Recent)", "Approx. Start Date (First)", "Approx. End Date (First)"]
        .each do |name|
          fill_in name, with: Faker::Date.between(from: 15.years.ago, to: Date.today).strftime("%B %d, %Y")
        end
      end

      fill_in "Total Number of Psychiatric Inpatient Hospitalizations", with: rand(40)

      [:member_application_psych_name, :member_application_recommend_name, :member_application_therapist_name, :member_application_primary_care_name,
        :member_application_emerg_primary_name, :member_application_emerg_secondary_name, :member_application_member_signature, :member_application_referral_signature]
        .each do |n|
          fill_in n, with: Faker::Name.name
        end
      [:member_application_recommend_agency, :member_application_psych_agency, :member_application_therapist_agency,
        :member_application_primary_care_agency, :member_application_recommend_agency_type,
        :member_application_hospital_first_name, :member_application_hospital_recent_name]
        .each do |n|
          fill_in n, with: Faker::Company.name
        end
      [:member_application_phone_number_landline, :member_application_phone_number_cell, :member_application_recommend_phone_number, :member_application_psych_phone, :member_application_therapist_phone,
        :member_application_primary_care_phone, :member_application_emerg_primary_phone, :member_application_emerg_secondary_phone]
        .each do |n|
          fill_in n, with: Faker::Number.number(digits: 10)
        end
      [:member_application_street_address, :member_application_psych_address, :member_application_therapist_address,
        :member_application_primary_care_address]
        .each do |n|
          fill_in n, with: Faker::Address.street_address
        end
      [:member_application_psych_seeing_length, :member_application_recommend_known_length, :member_application_therapist_seeing_length]
        .each do |n|
          fill_in n, with: "#{rand(12)} months"
        end
      [:member_application_psych_email, :member_application_email_address, :member_application_recommend_email, :member_application_therapist_email,
        :member_application_primary_care_email]
        .each do |n|
          fill_in n, with: Faker::Internet.email
        end
      fill_in :member_application_emerg_primary_relation, with: "Friend"
      fill_in :member_application_emerg_secondary_relation, with: "Mother"

      select("Medicare", from: (:member_application_insurance_name).to_s)
      fill_in :member_application_insurance_num, with: rand(5000000)

      select("Somewhat", from: (:member_application_get_needs_met).to_s)

      select("Somewhat", from: (:member_application_feel_part).to_s)

      select("Mostly", from: (:member_application_lack_companion).to_s)

      select("Mostly", from: (:member_application_left_out).to_s)

      select("Mostly", from: (:member_application_feel_isolated).to_s)

      [:member_application_satisfaction_physical_health, :member_application_satisfaction_mood, :member_application_satisfaction_work,
      :member_application_satisfaction_household, :member_application_satisfaction_social, :member_application_satisfaction_family,
      :member_application_satisfaction_leisure, :member_application_satisfaction_function, :member_application_satisfaction_economic,
      :member_application_satisfaction_living_sit, :member_application_satisfaction_get_around, :member_application_satisfaction_vision,
      :member_application_satisfaction_overall_sense, :member_application_satisfaction_medication,
      :member_application_satisfaction_overall_life].each do |n|
        select(["Good", "Fair"].sample, from: (n).to_s)
      end

      [:member_application_homeless_explanation, :member_application_med_alert_memo, :member_application_legal_history_detail,
        :member_application_why_fh_good_place]
        .each do |n|
          fill_in n, with: Faker::Lorem.paragraphs(3).join
        end
      [:member_application_med_alert_other, :member_application_past_treatment_when_and_where,
        :member_application_current_treatment_when_and_where, :member_application_main_goal_other_text, :member_application_what_challenges,
        :member_application_dsm_v]
        .each do |n|
          fill_in n, with: Faker::Lorem.paragraphs(1).join
        end

      [:member_application_have_homeless_history,
        :member_application_are_you_veteran, :member_application_harp, :member_application_hcbs, :member_application_abuse_history_alcohol,
        :member_application_abuse_history_drugs, :member_application_ever_in_treatment, :member_application_currently_in_treatment,
        :member_application_interested_in_treatment, :member_application_us_citizen, :member_application_have_children,
        :member_application_currently_employed, :member_application_ever_worked, :member_application_worked_last_12_months,
        :member_application_currently_tobacco, :member_application_history_tobacco, :member_application_abuse_history_alcohol,
        :member_application_abuse_history_drugs, :member_application_ever_in_treatment]
        .each do |n|
          select(["Yes", "No"].sample, from: (n).to_s)
        end

      select "Yes", from: "member_application_reside_with_minors"
      select "No", from: "member_application_acs_involvement"

      fill_in :member_application_num_years_of_work, with: Faker::Number.number(digits: 1)

      [:member_application_eth_aa,
        :member_application_med_alert_deaf, :member_application_med_alert_asthma,
        :member_application_med_alert_cpi, :member_application_med_alert_allerg, :member_application_med_alert_npm, :member_application_med_alert_blind,
        :member_application_med_alert_recent_surg, :member_application_med_alert_diabetes, :member_application_med_alert_ep,
        :member_application_med_alert_hyper, :member_application_less_hs, :member_application_some_hs, :member_application_ged, :member_application_hs_diploma, :member_application_trade_school,
        :member_application_some_college, :member_application_assoc_degree, :member_application_bachelors_degree, :member_application_some_grad_work,
        :member_application_masters_degree, :member_application_adv_grad_degree]
        .each do |n|
          check((n).to_s)
        end

      [:member_application_wanted_reduce_substance_use,
      :member_application_been_annoyed_by_substance_criticism, :member_application_felt_bad_about_substance_use,
      :member_application_ever_used_substances_for_hangover, :member_application_been_in_jail, :member_application_been_in_prison,
      :member_application_convicted_of_misdemeanor, :member_application_convicted_of_felony, :member_application_injured_another_person,
      :member_application_history_of_violence]
      .each do |n|
        choose("#{(n).to_s}_#{["no", "yes"].sample}")
      end

      choose("member_application_tour_fh_yes")

      select "The Best Clubhouse", from: "member_application_clubhouse_id"
    end
  end
end
