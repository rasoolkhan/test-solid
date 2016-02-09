module Spree
  class ContactMailer < BaseMailer
    def contact_email(fname, lname, email, subject, message)
      @fname = fname
      @lname = lname
      @email = email
      @subject = subject
      @message = message
      mail(to: 'neil@concretelabs.co', from: 'neil@concretelabs.co', subject: 'New message via contact form')
    end
  end
end
