module Spree
	class StorePolicy < ActiveRecord::Base
		belongs_to :store

    validates :store_id, presence: true
    validates :heading, presence: true
    validates :description, presence: true
	end
end
