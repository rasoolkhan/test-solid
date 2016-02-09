module Spree
  class ApprovalMailer < BaseMailer
    def store_approved_email(store)
      @store = store
      @user = @store.seller.user
      mail(to: @user.email, from: from_address(@store), subject: "Your store #{@store.name} has been approved.")
    end

    def product_approved_email(product)
      @product = product
      @store = @product.store
      @user = @store.seller.user
      mail(to: @user.email, from: from_address(@store), subject: "Your product #{@product.name} has been approved.")
    end
  end
end
