Spree::UserConfirmationsController.class_eval do

  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      if spree_current_user.is_seller?
        supplier_store_path(spree_current_user.seller.store)
      else
        signed_in_root_path(resource)
      end
    else
      spree.login_path
    end
  end

end
