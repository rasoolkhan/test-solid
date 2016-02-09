module Spree
  UserAddress.class_eval do

    accepts_nested_attributes_for :address

  end
end
