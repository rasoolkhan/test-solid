Deface::Override.new(:virtual_path => 'spree/users/show',
  :name => 'add_ship_address_to_user',
  :insert_after => "[data-hook = 'account_my_orders']",
  :text => "
    <%= render :partial => 'buyer_settings' unless @user.seller? %>
  ")