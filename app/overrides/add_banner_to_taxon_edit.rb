Deface::Override.new(:virtual_path => 'spree/admin/taxons/_form',
  :name => 'add_banner_to_taxon_edit',
  :insert_after => "erb[loud]:contains('file_field :icon')",
  :text => "
    <%= f.field_container :start_date, class: ['form-group'] do %>
        <%= f.label :start_date, Spree.t(:start_date) %>
        <%= datetime_field_tag :start_date %>
      <% end %>

      <%= f.field_container :end_date, class: ['form-group'] do %>
        <%= f.label :end_date, Spree.t(:end_date) %>
        <%= datetime_field_tag :end_date %>
      <% end %>

      <div>Image</div>
      <%= f.fields_for :images,@taxon.images.build do |f_image| %>
        <%= f_image.file_field :attachment %>
      <% end %>

      <% unless is_original_natty_pick?(@taxon) %>
        <div>Add to Natty's pick?
          <%= check_box_tag :add_to_natty_pick %>
         </div>
      <% end %>
      
  ")