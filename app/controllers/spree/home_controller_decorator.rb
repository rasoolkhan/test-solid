module Spree
  HomeController.class_eval do
    def sale
      @products = Product.joins(:variants_including_master).where('spree_variants.sale_price is not null').uniq
    end

    def index
    end


    def trending_products
      category_selected = params[:cat_id].present? ? params[:cat_id].to_i : 1
      page = params[:page].present? ? params[:page].to_i : 1
      products_pr_pg = 5
      trending_product_count = Spree::TrendingProduct.count
      category = Spree::Taxonomy.first.taxons.find(category_selected)
      current_page_products = products_pr_pg*(page-1)+1..products_pr_pg*page
      trending_products = Spree::TrendingProduct.where(:id => current_page_products)
      @trending_data = {}
      trending_products.each_with_index {
        |t,i|
        t_product = {}
        p = t.product
        t_product["name"] = p.name
        t_product["url"] = product_path(p)
        t_product["image"] = p.master_images.first
        t_product["store"] = p.store.name
        t_product["price"] = p.price

        @trending_data[i] = t_product

      }

      respond_to do |format|
        format.html { @trending_data }
        format.js {}
        format.json {render json: @trending_data}
      end
    end

    def nattypick
      existing_natty_picks = Spree::NattyPick.all.pluck(:taxon_id)
      new_natty_picks = Spree::Taxon.find_by_name('NattyPick').children.pluck(:id)
      @all_natty_pick_taxons = existing_natty_picks + new_natty_picks

      respond_to do |format|
        format.html { @all_natty_pick_taxons }
        format.js {}
        format.json {render json: @all_natty_pick_taxons}
      end
    end

    def latest_banner
      seed = params[:seed].to_i
      count = params[:count].to_i
      page = params[:page].to_i
      banner_products = Spree::BannerProduct.all
      product_ids = banner_products.map(&:product_id)
      srand seed
      banner_product_ids = product_ids.sample(page*count).last(count)
      @banner_images = {}
      banner_product_ids.each {
        |p_id| p = Spree::Product.find(p_id)
        @banner_images[product_url(p)] = p.master_images.first.attachment.url
      }

      respond_to do |format|
        format.html {@banner_images}
        format.js {}
        format.json {@banner_images}
      end
    end

    def new_banner
      if params[:banner_ids].present?
        banner_product_ids = params[:banner_ids].split(',')
      else
        banner_product_ids = Spree::BannerProduct.ids
      end

      banner_products = Spree::BannerProduct.where(:id => banner_product_ids)
      product_ids = banner_products.map(&:product_id)
      products = Spree::Product.where(:id => product_ids)
      product_data = {}
      @banner_images = {}
      products.each {
        |p| @banner_images[product_url(p)] = p.master_images.first.attachment.url
      }


      respond_to do |format|
        format.html {@banner_images}
        format.js {}
        format.json {@banner_images}
      end
    end

    def banner
      seed = params[:seed].present? ? params[:seed].to_i : Random.new_seed
      page = params[:page].present? ? params[:page].to_i : 1
      count = 10
      product_total = Spree::Product.count
      last_page = product_total/count
      page = 1 if last_page == page
      gen_rand = Random.new(seed)
      product_ids = Spree::Product.ids
      random_nums = Array.new(page*count) {gen_rand.rand(product_total)}.last(count)
      products = Spree::Product.where(:id => random_nums)
      banner_images = []
      products.each { |p|
       image = p.master_images.first.attachment.url unless p.master_images.blank?
       banner_images << image
        }
      @banner_data = {:seed => seed, :images => banner_images,:page => page}
       respond_to do |format|
         format.html { @banner_data }
         format.js {}
         format.json {render json: @banner_images}
       end

    end

  end
end
