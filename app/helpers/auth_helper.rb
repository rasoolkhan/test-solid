module AuthHelper
  def auth_signed_in
    redirect_to root_path unless spree_current_user
  end

  def correct_signed_in(user)
    redirect_to root_path unless spree_current_user == user
  end

  def auth_not_signed_in
    redirect_to root_path if spree_current_user
  end

  def auth_buyer
    redirect_to root_path unless (spree_current_user && spree_current_user.is_buyer_only?)
  end

  def correct_buyer(user)
    redirect_to root_path unless ((spree_current_user == user) && (spree_current_user.is_buyer_only?))
  end

  def auth_not_buyer
    redirect_to root_path unless (spree_current_user && !spree_current_user.is_buyer_only?) || (!spree_current_user)
  end

  def auth_seller
    redirect_to root_path unless (spree_current_user && spree_current_user.is_seller?)
  end

  def correct_seller(user)
    redirect_to root_path unless ((spree_current_user == user) && (spree_current_user.is_seller?))
  end

  def auth_not_seller
    redirect_to root_path unless (spree_current_user && !spree_current_user.is_seller?) || (!spree_current_user)
  end

  def auth_admin
    redirect_to root_path unless (spree_current_user && spree_current_user.admin?)
  end

  def correct_admin(user)
    redirect_to root_path unless ((spree_current_user == user) && (spree_current_user.admin?))
  end

  def auth_not_admin
    redirect_to root_path unless (spree_current_user && !spree_current_user.admin?) || (!spree_current_user)
  end

  def store_approved
    store = Spree::Store.friendly.find(params[:store_id])
    unless store.approved?
      flash[:error] = "Your store is not yet approved."
      redirect_to supplier_store_path(store)
    end
  end
end
