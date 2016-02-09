Deface::Override.new(:virtual_path => 'spree/products/show',
  :name => 'modify_product_show',
  :insert_before => "[data-hook = 'promotions']",
  :text => "
    <% if spree_user_signed_in? %>
      <% if spree_current_user.is_superadmin? %>
        <%= form_tag(admin_natty_pick_path,method: 'post') do %>
          <div>
            <%= hidden_field_tag :product_id, @product.id %>
          </div>
          <div>
            <%= select_tag 'natty_pick',options_for_select(natty_pick_categories+sale_categories),multiple: true,prompt: 'Select Subcategory'%>
          </div>
          <div>
            <%= submit_tag 'Submit'%>
          </div>
        <% end %>
      <% end %>
    <% end %>
  ")






