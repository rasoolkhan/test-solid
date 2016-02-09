module Spree
  class MailerPreviews
    class ApprovalMailerPreview < ActionMailer::Preview
      def store
        Spree::ApprovalMailer.store_approved_email(Spree::Store.find(2))
      end

      def product
        Spree::ApprovalMailer.product_approved_email(Spree::Product.first)
      end
    end
  end
end
