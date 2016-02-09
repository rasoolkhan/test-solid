module Spree
  class StaticPagesController < Spree::StoreController
    def aboutus
    end

    def partnerships
    end

    def careers
    end

    def contact
      if spree_current_user
        @user = spree_current_user
      else
        @user = Spree::User.new
      end
    end

    def contact_submit
      Spree::ContactMailer.contact_email(
        params[:user][:first_name],
        params[:user][:last_name],
        params[:user][:email],
        params[:subject],
        params[:message]
      ).deliver_later
      flash[:notice] = "Thank you for contacting us. We will get back to you soon."
      redirect_to root_path
    end

    def whyshopwithus
    end

    def faqs
    end

    def shippingreturns
    end
  end
end
