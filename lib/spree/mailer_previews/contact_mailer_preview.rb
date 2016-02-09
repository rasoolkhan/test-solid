module Spree
  class MailerPreviews
    class ContactMailerPreview < ActionMailer::Preview
      def contact
        Spree::ContactMailer.contact_email("Neil", "Deshpande", "neil@concretelabs.co", "Test", "Test Body")
      end
    end
  end
end
