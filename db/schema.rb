# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_11_005207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "application_logs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "member_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ssn"
    t.string "first_name"
    t.string "last_name"
    t.string "mi"
    t.string "dob"
    t.string "age"
    t.string "gender"
    t.string "street_address"
    t.string "apt"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "phone_number"
    t.string "county"
    t.string "residence_time_length"
    t.string "email_address"
    t.string "recommend_name"
    t.string "recommend_agency"
    t.string "recommend_phone_number"
    t.string "recommend_agency_type"
    t.string "recommend_known_length"
    t.string "who_live_with"
    t.string "ssi"
    t.string "family_income"
    t.string "veteran_benefits"
    t.string "ssdi"
    t.string "snap"
    t.string "public_assistance"
    t.string "wages"
    t.string "retirement_benefits"
    t.string "other_income"
    t.string "total_income"
    t.string "recommend_email"
    t.string "other_language"
    t.string "med_alert_other"
    t.string "psych_seeing_length"
    t.string "psych_email"
    t.string "therapist_seeing_length"
    t.string "therapist_email"
    t.string "primary_care_email"
    t.string "emerg_primary_name"
    t.string "emerg_primary_phone"
    t.string "emerg_primary_relation"
    t.string "emerg_secondary_name"
    t.string "emerg_secondary_phone"
    t.string "emerg_secondary_relation"
    t.string "medicaid_comp"
    t.string "psych_name"
    t.string "psych_agency"
    t.string "psych_phone"
    t.string "psych_address"
    t.string "therapist_name"
    t.string "therapist_agency"
    t.string "therapist_phone"
    t.string "therapist_address"
    t.string "primary_care_address"
    t.string "primary_care_name"
    t.string "primary_care_agency"
    t.string "primary_care_phone"
    t.string "insurance_num"
    t.string "hospitalization_count"
    t.string "past_treatment_when_and_where"
    t.string "current_treatment_when_and_where"
    t.string "bronx_or_manhattan"
    t.string "member_signature"
    t.string "insurance_other"
    t.string "wanted_reduce_substance_use"
    t.string "been_annoyed_by_substance_criticism"
    t.string "felt_bad_about_substance_use"
    t.string "ever_used_substances_for_hangover"
    t.string "been_in_jail"
    t.string "been_in_prison"
    t.string "convicted_of_misdemeanor"
    t.string "injured_another_person"
    t.string "history_of_violence"
    t.string "med_name_1"
    t.string "med_name_2"
    t.string "med_name_3"
    t.string "med_name_4"
    t.string "med_name_5"
    t.string "med_name_6"
    t.string "med_dosage_1"
    t.string "med_dosage_2"
    t.string "med_dosage_3"
    t.string "med_dosage_4"
    t.string "med_dosage_5"
    t.string "med_dosage_6"
    t.string "med_freq_1"
    t.string "med_freq_2"
    t.string "med_freq_3"
    t.string "med_freq_4"
    t.string "med_freq_5"
    t.string "med_freq_6"
    t.string "main_goal_other_text"
    t.text "what_challenges"
    t.string "children_number"
    t.string "referral_signature"
    t.string "tour_fh"
    t.string "us_citizen"
    t.string "main_goal"
    t.string "current_housing_type"
    t.string "live_alone_or_with_others"
    t.string "reside_with_minors"
    t.string "acs_involvement"
    t.string "have_homeless_history"
    t.string "marital_status"
    t.string "have_children"
    t.string "are_you_veteran"
    t.string "get_needs_met"
    t.string "feel_part"
    t.string "ever_worked"
    t.string "worked_last_12_months"
    t.string "insurance_name"
    t.string "harp"
    t.string "hcbs"
    t.string "abuse_history_alcohol"
    t.string "abuse_history_drugs"
    t.string "ever_in_treatment"
    t.string "currently_in_treatment"
    t.string "interested_in_treatment"
    t.text "homeless_explanation"
    t.text "med_alert_memo"
    t.text "dsm_v"
    t.text "legal_history_detail"
    t.integer "eth_aa"
    t.integer "eth_na"
    t.integer "eth_aa_ac"
    t.integer "eth_cuban"
    t.integer "eth_mex"
    t.integer "eth_pr"
    t.integer "eth_dom"
    t.integer "eth_sa"
    t.integer "eth_ca"
    t.integer "eth_pi"
    t.integer "less_hs"
    t.integer "trade_school"
    t.integer "some_grad_work"
    t.integer "some_hs"
    t.integer "some_college"
    t.integer "masters_degree"
    t.integer "ged"
    t.integer "assoc_degree"
    t.integer "adv_grad_degree"
    t.integer "hs_diploma"
    t.integer "bachelors_degree"
    t.integer "med_alert_deaf"
    t.integer "med_alert_recent_surg"
    t.integer "med_alert_asthma"
    t.integer "med_alert_diabetes"
    t.integer "med_alert_cpi"
    t.integer "med_alert_npm"
    t.integer "med_alert_ep"
    t.integer "med_alert_allerg"
    t.integer "med_alert_blind"
    t.integer "med_alert_hyper"
    t.integer "application_status", default: 0
    t.date "tour_date"
    t.date "last_physical_exam_date"
    t.date "last_dental_exam_date"
    t.date "referral_signature_date"
    t.date "member_signature_date"
    t.date "application_expiration_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "satisfaction_physical_health"
    t.string "satisfaction_mood"
    t.string "satisfaction_work"
    t.string "satisfaction_household"
    t.string "satisfaction_social"
    t.string "satisfaction_family"
    t.string "satisfaction_leisure"
    t.string "satisfaction_function"
    t.string "satisfaction_economic"
    t.string "satisfaction_living_sit"
    t.string "satisfaction_get_around"
    t.string "satisfaction_vision"
    t.string "satisfaction_overall_sense"
    t.string "satisfaction_medication"
    t.string "satisfaction_overall_life"
    t.string "hospital_recent_name"
    t.string "hospital_first_name"
    t.string "housing_agency_program_name"
    t.string "currently_employed"
    t.string "num_years_of_work"
    t.string "currently_tobacco"
    t.string "history_tobacco"
    t.string "convicted_of_felony"
    t.string "lack_companion"
    t.string "left_out"
    t.string "feel_isolated"
    t.text "why_fh_good_place"
    t.date "hospital_recent_start_date"
    t.date "hospital_recent_end_date"
    t.date "hospital_first_start_date"
    t.date "hospital_first_end_date"
    t.integer "eth_aa_carrib"
    t.integer "eth_black_other"
    t.integer "eth_asian_fe"
    t.integer "eth_asian_se"
    t.integer "eth_asian_is"
    t.integer "eth_white_na"
    t.integer "eth_white_me"
    t.integer "eth_white_amer"
    t.integer "eth_white_eu"
    t.integer "eth_white_other"
    t.string "phone_number_type", default: "unknown"
  end

end
