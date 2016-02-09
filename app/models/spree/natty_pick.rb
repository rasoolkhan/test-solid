module Spree
	class NattyPick < ActiveRecord::Base
		validates :taxon_id, presence: true, uniqueness: true
	end
end

