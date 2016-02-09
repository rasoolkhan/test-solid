Spree::BaseHelper.module_eval do
  def seo_url(taxon)
    return spree.shop_path(taxon.permalink)
  end
end
