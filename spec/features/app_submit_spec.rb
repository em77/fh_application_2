require "rails_helper"

feature "app submit" do
  scenario "user can submit an app with valid attachments" do
    visit new_member_application_path
    page.attach_file(
        "member_application_psych_eval",
        Rails.root.join("lib/sample_attachments/notes.pdf")
      )
    page.attach_file(
      "member_application_psych_social",
      Rails.root.join("lib/sample_attachments/utopia.pdf")
    )
    page.attach_file(
        "member_application_insurance_card",
        Rails.root.join("lib/sample_attachments/sun.jpg")
      )
    fill_out_app
    click_on "Submit Application"
    expect(page).to have_content "Your application was submitted successfully"
  end

  scenario "user cannot submit an app with spoofed attachments" do
    visit new_member_application_path
    page.attach_file(
        "member_application_psych_eval",
        Rails.root.join("lib/sample_attachments/notes.pdf")
      )
    page.attach_file(
      "member_application_psych_social",
      Rails.root.join("lib/sample_attachments/spoof.pdf")
    )
    page.attach_file(
        "member_application_insurance_card",
        Rails.root.join("lib/sample_attachments/sun.jpg")
      )
    fill_out_app
    click_on "Submit Application"
    expect(page).to have_content ("Psychosocial History must be an accepted file type (.pdf, .doc, .docx, .jpg)")
  end
end
