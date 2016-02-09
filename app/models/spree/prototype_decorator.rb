module Spree
  Prototype.class_eval do
    belongs_to :store

    validates :store, presence: true
  end
end
