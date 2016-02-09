class Spree::PayuInPayment < Spree::Base
  belongs_to :payment_method
  belongs_to :user, class_name: Spree.user_class, foreign_key: 'user_id'
  belongs_to :address
  accepts_nested_attributes_for :address

  def address_attributes=(attributes)
    self.address = Spree::Address.immutable_merge(address, attributes)
  end

  def actions
    %w{capture void credit}
  end

  def can_capture?(payment)
    payment.pending? || payment.checkout?
  end

  def can_void?(payment)
    !payment.failed? && !payment.void?
  end

  def can_credit?(payment)
    payment.completed? && payment.credit_allowed > 0
  end
end
