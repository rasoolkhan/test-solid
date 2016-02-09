Deface::Override.new(
:name          => "frontent_add_to_head_bottom",
:virtual_path  => "spree/layouts/spree_application",
:insert_bottom => "[data-hook='inside_head']",
:original     => 'a6a00e37a5bd63d553dcf174918532d2c3f8c550',
:text          => "
<% if controller.class.name.split('::')[1] == 'Supplier' and !request.path.include?('stores/new')%>
  <%= stylesheet_link_tag 'supplier' %>
  <%= javascript_include_tag 'supplier' %>
<% else %>
  <%= stylesheet_link_tag 'buyer' %>
  <%= javascript_include_tag 'buyer' %>
<% end %>
",)
