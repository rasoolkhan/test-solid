Deface::Override.new(:virtual_path => 'spree/products/show',
  :name => 'add_new_banner_link_to_product',
  :insert_before => "[data-hook = 'product_show']",
  :text => "

    <% if spree_user_signed_in? && spree_current_user.is_superadmin? %>
      <div>
        <% @banner_product = Spree::BannerProduct.new %>
        <h1>Add to Banner</h1>
        <%= form_for [:admin,@banner_product], :remote => true do |f|%>
          <%= hidden_field_tag :product_id, @product.id %>
          <%= f.button 'Add to banner products' %>
        <% end %>
      </div>
    <% end %>
  ")