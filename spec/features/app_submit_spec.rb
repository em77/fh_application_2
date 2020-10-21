require "rails_helper"

feature "app submit" do
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

    accept_confirm do
      click_on "Submit Application"
    end

    sleep 10

    expect(page).to have_content "Your application was submitted successfully"
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
  end

  scenario "user saves draft, then adds the missing attachment and submits", js: true do
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
    expect(ActionMailer::Base.deliveries).to be_empty

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
    mail = ActionMailer::Base.deliveries.first
    expect(mail).to_not be nil
    expect(mail.body.raw_source).to include "https://www.fhapplication.org/member_applications/#{MemberApplication.last.id}"
  end
end
