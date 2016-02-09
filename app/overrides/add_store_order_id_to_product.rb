Deface::Override.new(:virtual_path => 'spree/shared/_order_details',
  :name => 'add_store_order_id_to_product',
  :insert_after => "[data-hook='order_item_description']",
  :text => "
    <td data-hook='seller_order_id' class='order-qty'><%= item.store_order_id %></td>
  ")