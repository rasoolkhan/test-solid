Deface::Override.new(:virtual_path => 'spree/shared/_login_bar',
  :name => 'add_store_to_login_bar',
  :insert_before => "li:contains('t(:my_account)')",
  :text => 
  
  '
    <% if spree_current_user.is_seller?%>
        <li><%= link_to Spree.t(:my_store), mystore_path %></li> 
    <% else %>
        <li><%= link_to Spree.t(:create_a_store), new_supplier_store_path %></li>
    <% end %>
  ' 
  )


