Deface::Override.new(:virtual_path => 'spree/products/_cart_form',
  :name => 'add_store_id_to_cart_form',
  :insert_after => "[data-hook = 'product_price']",
  :text => "
    <%= hidden_field_tag 'store_id', @product.store.id %>
  ")