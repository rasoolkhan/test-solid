class Spree::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if request.env['omniauth.error'].present?
      flash[:error] = 'There was an error in signing in with Facebook.'
      redirect_back_or_default(root_url)
      return
    end

    @user = Spree::User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      if @user.is_seller?
        sign_in @user, event: :authentication
        redirect_to supplier_store_path(@user.seller.store)
      else
        sign_in_and_redirect @user
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem with signing in via Facebook.'
    redirect_to root_path
  end
end
