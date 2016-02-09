module Spree
	class BankDetail < ActiveRecord::Base
		belongs_to :seller
	end
end