## Fountain House Application Submitter
#### Web app for applying to the [Fountain House](http://www.fountainhouse.org) organization that takes user input and attachments, uploads the files to an S3 bucket, and e-mails the completed application links to the relevant department.
#### The new version of this app allows saving drafts of an application to return to later, Twilio verification of phone number line types for flagging compatibility with Fountain House's SMS service, favors secure URLs for accessing draft and submitted applications over the previous system of e-mailing PDFs, while still allowing PDF generation of the application page for record-keeping purposes.
#### Behind the scenes it's also now powered by Rails 6 and Webpacker.

See it live: https://www.fhapplication.org/