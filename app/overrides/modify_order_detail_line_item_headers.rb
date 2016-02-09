Deface::Override.new(:virtual_path => 'spree/shared/_order_details',
  :name => 'modify_order_detail_line_item_headers',
  :insert_after => "[data-hook = 'order_details_line_items_headers']:contains('t(:item)')",
  :text => "
     <th class='qty'><%= Spree.t(:seller_order_id) %></th>
  ")
