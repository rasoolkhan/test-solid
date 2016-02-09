module ApplicationHelper
  def main_categories
    Spree::Taxonomy.where(name: 'categories').first.taxons.where(depth: 1).order('id ASC')
  end

  def all_categories
    Spree::Taxonomy.where(name: 'categories').first.taxons.where('depth > 1').order(permalink: :asc)
  end

  def level_2_categories(main_category_name)
    Spree::Taxon.where(name: main_category_name).first.children.where(depth: 2).order('id ASC')
  end

  def level_3_categories(main_category, level_2_category_name)
    Spree::Taxon.where(name: level_2_category_name, parent_id: main_category.id).first.children.where(depth: 3).order('id ASC')
  end

  def main_category(category)
    retVal = category
    (category.depth - 1).times do
      retVal = retVal.parent
    end
    retVal
  end

  def level_2_category(category)
    retVal = category
    (category.depth - 2).times do
      retVal = retVal.parent
    end
    retVal
  end

  def level_3_category(category)
    retVal = category
    (category.depth - 3).times do
      retVal = retVal.parent
    end
    retVal
  end

  def cart_count
    current_order.present? ? current_order.item_count : 0
  end

  def variant_count(store)
    Spree::Variant.where(is_master: false, product: store.products).count
  end

  def newsletter_signup
    Spree::NewsletterSignup.new
  end

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def is_active_controller_action(controller_name, action_name)
    (params[:controller] == controller_name) && (params[:action] == action_name) ? "active" : nil
  end

  def link_to_show(resource, options={})
    options[:data] = {:action => 'show'}
    link_to_with_icon('eye', 'Show', object_url(resource), options)
  end
end
