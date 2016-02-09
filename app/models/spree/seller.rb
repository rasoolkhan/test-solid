module Spree
	class Seller < ActiveRecord::Base
		extend FriendlyId
    friendly_id :slug_candidates, use: :history

		has_one :store
		has_many :orders
		belongs_to :user

		validates :user_id, presence: true, uniqueness: true
		validates :name, presence: true

		scope :by_status,-> status {where(status: status)}

		def products_allowed?
			bank_name.present? && bank_branch.present? && bank_account_name.present? && bank_account_number.present? && bank_ifsc.present? && bank_pan.present? && bank_tin.present? && bank_vat.present?
		end

		def slug_candidates
			"seller - #{id}"
		end

		def self.to_csv
		end
	end
end
