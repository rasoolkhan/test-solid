Deface::Override.new(
:name         => "frontent_add_to_head_top",
:virtual_path => "spree/layouts/spree_application",
:insert_top   => "[data-hook='inside_head']",
:original     => 'd6b0d546b0acd27f2d20259ed4937313f91ba3d4',
:text         => "
<% content_for :head do %>
  <script src='https://use.typekit.net/nsk6qof.js'></script>
  <script>try{Typekit.load({ async: true });}catch(e){}</script>
<% end %>
",)
