require "rails_helper"

feature "app submit" do
  before do
    Clubhouse.create(name: "The Best Clubhouse", email_address: "best@example.com")
    Clubhouse.create(name: "The Second Best Clubhouse", email_address: "secondbest@example.com")
  end

  scenario "user can submit an app with valid attachments", js: true do
    visit new_member_application_path
    page.attach_file(
      "member_application_psych_eval",
      Rails.root.join("lib/sample_attachments/notes.pdf"),
      make_visible: true
    )
    page.attach_file(
      "member_application_psych_social",
      Rails.root.join("lib/sample_attachments/utopia.pdf"),
      make_visible: true
    )
    page.attach_file(
      "member_application_insurance_card",
      Rails.root.join("lib/sample_attachments/sun.jpg"),
      make_visible: true
    )

    fill_out_app(true)

    expect_any_instance_of(Twilio::REST::Client).to receive_message_chain('lookups.phone_numbers.fetch').and_return({ 'type' => 'mobile' })

    accept_confirm do
      click_on "Submit Application"
    end

    sleep 10

    expect(page).to have_content "Your application was submitted successfully"
    expect(page).to have_content("Application Submitted!")
    mail = ActionMailer::Base.deliveries.first
    expect(mail).to_not be nil
    expect(mail.body.raw_source).to include "https://www.fhapplication.org/member_applications/#{MemberApplication.last.id}"
  end

  scenario "user cannot submit an app with spoofed attachments", js: true do
    visit new_member_application_path
    page.attach_file(
      "member_application_psych_eval",
      Rails.root.join("lib/sample_attachments/notes.pdf"),
      make_visible: true
    )
    page.attach_file(
      "member_application_psych_social",
      Rails.root.join("lib/sample_attachments/spoof.pdf"),
      make_visible: true
    )
    page.attach_file(
      "member_application_insurance_card",
      Rails.root.join("lib/sample_attachments/sun.jpg"),
      make_visible: true
    )

    fill_out_app(true)

    accept_confirm do
      click_on "Submit Application"
    end

    sleep 10

    expect(page).to have_content ("Psychosocial History must be an accepted file type (.pdf, .doc, .docx, .jpg, .png)")
    expect(ActionMailer::Base.deliveries).to be_empty
    expect(page).to_not have_content("Application Submitted!")
  end

  scenario "user cannot submit an application with missing required attributes", js: true do
    visit new_member_application_path
    page.attach_file(
      "member_application_psych_eval",
      Rails.root.join("lib/sample_attachments/notes.pdf"),
      make_visible: true
    )
    page.attach_file(
      "member_application_psych_social",
      Rails.root.join("lib/sample_attachments/utopia.pdf"),
      make_visible: true
    )
    page.attach_file(
      "member_application_insurance_card",
      Rails.root.join("lib/sample_attachments/sun.jpg"),
      make_visible: true
    )

    fill_out_app(true)

    # Remove phone numbers
    fill_in :member_application_phone_number_landline, with: ''
    fill_in :member_application_phone_number_cell, with: ''

    accept_confirm do
      click_on "Submit Application"
    end

    sleep 10

    expect(page).to_not have_content "Your application was submitted successfully"
    expect(page).to_not have_content("Application Submitted!")
    expect(ActionMailer::Base.deliveries).to be_empty
  end

  scenario "user saves draft, then adds the missing attachment, then submits without phone number and then successfully submits", js: true do
    visit new_member_application_path
    page.attach_file(
      "member_application_psych_eval",
      Rails.root.join("lib/sample_attachments/notes.pdf"),
      make_visible: true
    )

    page.attach_file(
      "member_application_psych_social",
      Rails.root.join("lib/sample_attachments/utopia.pdf"),
      make_visible: true
    )

    fill_out_app(true)
    click_on "Save Draft"

    expect(page).to have_content ("You can return to this form until")
    expect(page).to_not have_content("Application Submitted!")
    expect(ActionMailer::Base.deliveries.count).to eq 2

    page.attach_file(
      "member_application_insurance_card",
      Rails.root.join("lib/sample_attachments/sun.jpg"),
      make_visible: true
    )

    # Remove phone numbers
    fill_in :member_application_phone_number_landline, with: ''
    fill_in :member_application_phone_number_cell, with: ''
    ActionMailer::Base.deliveries.clear

    accept_confirm do
      click_on "Submit Application"
    end

    sleep 10

    expect(page).to have_content ("Either Phone number (landline) or Phone number (cell) must be entered")
    expect(ActionMailer::Base.deliveries).to be_empty
    expect(page).to_not have_content("Application Submitted!")

    # Restore a phone number
    fill_in :member_application_phone_number_cell, with: Faker::Number.number(digits: 10)

    expect_any_instance_of(Twilio::REST::Client).to receive_message_chain('lookups.phone_numbers.fetch').and_return({ 'type' => 'mobile' })

    ActionMailer::Base.deliveries.clear

    page.attach_file(
      "member_application_insurance_card",
      Rails.root.join("lib/sample_attachments/sun.jpg"),
      make_visible: true
    )

    accept_confirm do
      click_on "Submit Application"
    end

    sleep 10

    expect(page).to have_content "Your application was submitted successfully"
    expect(page).to have_content("Application Submitted!")
    expect(ActionMailer::Base.deliveries.count).to eq 3
    mail = ActionMailer::Base.deliveries.first
    expect(mail).to_not be nil
    expect(mail.body.raw_source).to include "https://www.fhapplication.org/member_applications/#{MemberApplication.last.id}"
  end
end
