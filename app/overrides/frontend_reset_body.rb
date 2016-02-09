Deface::Override.new(
:name         => "frontend_reset_body",
:virtual_path => "spree/layouts/spree_application",
:replace      => "[data-hook='body']",
:original => 'fefa0946a0017c6611880f0b9fc3a1529eefe276',
:text         => "
<body id='<%= @body_id %>'>
  <% if controller.class.name.split('::')[1] != 'Supplier' || request.path.include?('stores/new') %>
    <%= render :partial => 'spree/shared/header' %>
  <% end %>
  <%= yield %>
  <% if controller.class.name.split('::')[1] != 'Supplier' || request.path.include?('stores/new') %>
    <%= render :partial => 'spree/shared/footer' %>
  <% end %>
</body>
",)
