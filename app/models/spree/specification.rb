module Spree
  class Specification < ActiveRecord::Base
    default_scope {order(id: :asc)}

    belongs_to :product

    validates :product, presence: true
    validates :spec, presence: true
  end
end
