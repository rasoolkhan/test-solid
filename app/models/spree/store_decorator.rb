module Spree
	Store.class_eval do
		extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

		enum status: [:pending, :approved, :declined, :suspended]

		belongs_to :seller
		has_one :office_address, class_name: 'Spree::UserAddress', dependent: :destroy
		has_many :taxons, through: :products
		has_many :sample_store_taxons, dependent: :destroy, class_name: "Spree::SampleStoreTaxon"
		has_many :sample_taxons, through: :sample_store_taxons, source: :taxon, class_name: "Spree::Taxon"
		has_one :image, as: :viewable, dependent: :destroy, class_name: "Spree::ImageBanner"
		has_one :logo, as: :viewable, dependent: :destroy, class_name: "Spree::ImageLogo"
		has_many :product_samples, dependent: :destroy, class_name: 'Spree::ProductSample'
		has_many :properties, dependent: :destroy, class_name: 'Spree::Property'
		has_many :option_types, dependent: :destroy, class_name: 'Spree::OptionType'
		has_many :prototypes, dependent: :destroy, class_name: 'Spree::Prototype'
		has_one :stock_location, class_name: 'Spree::StockLocation'
		has_many :store_orders, dependent: :destroy, class_name: 'Spree::StoreOrder'
		has_many :orders, through: :store_orders
		has_many :policies, dependent: :destroy, class_name: 'Spree::StorePolicy'

		accepts_nested_attributes_for :seller
		accepts_nested_attributes_for :office_address
		accepts_nested_attributes_for :image
		accepts_nested_attributes_for :logo
		accepts_nested_attributes_for :product_samples
		accepts_nested_attributes_for :policies

		validates :image, presence: true
		validates :logo, presence: true
		validates :description, presence: true

		def slug_candidates
		[
			:name_string,
			[:name_string, :name_index]
		]
		end

		def name_string
			name
	  end

		def name_index
			Spree::Store.where(name: name).count
	  end

		def categories
			taxons.uniq
		end

		def self.to_csv
			::CSV.generate do |csv|
				csv << [
					'Company Name',
					'Address Line 1',
					'Address Line 2',
					'City',
					'State',
					'Pin Code',
					'Primary Contact',
					'Primary Email',
					'Primary Phone',
					'Secondary Contact',
					'Secondary Email',
					'Secondary Phone',
					'Bank Name',
					'Bank Branch',
					'Bank Address',
					'Account Name',
					'Account Number',
					'IFSC',
					'MICR',
					'PAN',
					'TIN',
					'VAT',
					'Store Name',
					'Store Facebook URL',
					'Store Twitter URL',
					'Store Website URL',
					'Status',
					'Products',
					'Variants'
				]
				where.not(id: 1).each do |store|
					csv << [
						store.seller.name,
						store.office_address.address.address1,
						store.office_address.address.address2,
						store.office_address.address.city,
						store.office_address.address.state.name,
						store.office_address.address.zipcode,
						"#{store.seller.user.first_name} #{store.seller.user.last_name}",
						store.seller.user.email,
						store.office_address.address.phone,
						store.seller.alternate_name,
						store.seller.alternate_email,
						store.seller.alternate_phone,
						store.seller.bank_name,
						store.seller.bank_branch,
						store.seller.bank_address,
						store.seller.bank_account_name,
						store.seller.bank_account_number,
						store.seller.bank_ifsc,
						store.seller.bank_micr,
						store.seller.bank_pan,
						store.seller.bank_tin,
						store.seller.bank_vat,
						store.name,
						store.social_urls.split(",")[0],
						store.social_urls.split(",")[1],
						store.social_urls.split(",")[2],
						store.status,
						store.products.count,
						Spree::Variant.where(is_master: false, product: store.products).count
					]
				end
			end
		end

		def self.min_price
			joins(products: :prices).minimum('spree_prices.amount').to_i
		end

		def min_price
			products.joins(:prices).minimum('spree_prices.amount').to_i
		end

		def self.max_price
			joins(products: :prices).maximum('spree_prices.amount').to_i
		end

		def max_price
			products.joins(:prices).maximum('spree_prices.amount').to_i
		end



		has_many :products, class_name: 'Spree::Product'
		has_one :ship_address, class_name: 'Spree::Address'

		accepts_nested_attributes_for :products
		accepts_nested_attributes_for :ship_address

	end
end
