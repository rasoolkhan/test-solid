class Spree::Gateway::PayuIn < Spree::Gateway
  test_url = "https://test.payu.in/_payment"
  live_url = "https://secure.payu.in/_payment"

  def provider_class
    Spree::Gateway::PayuIn
  end

  def payment_source_class
    Spree::PayuInPayment
  end

  def method_type
    'payu_in'
  end

  def source_required?
    true
  end

  def auto_capture?
    true
  end

  def payment_profiles_supported?
    false
  end

  def can_capture?(payment)
    ['pending', 'checkout'].include?(payment.state)
  end

  def can_void?(payment)
    !payment.failed? && !payment.void?
  end

  def purchase(money, payment, options = {})
    if payment.status == 'success'
      if payment.responseHash == payment.verifyHash
        ActiveMerchant::Billing::Response.new(true, 'Payment success', {}, {})
      else
        ActiveMerchant::Billing::Response.new(false, 'Payment failure', {message: 'Verification failed'}, {})
      end
    else
      ActiveMerchant::Billing::Response.new(false, 'Payment failure', {message: payment.error_message}, {})
    end
  end

  def self.submitHash(order)
    retVal = {}
    source = order.unprocessed_payments.last.source
    address = source.address
    retVal[:submit] = urls[:submit]
    retVal[:key] = key_salt[:key]
    retVal[:txnid] = order.number.truncate(25, omission: '')
    retVal[:amount] = order.total.truncate(2).to_s('F')
    retVal[:productinfo] = 'Natty.in Purchase'
    retVal[:firstname] = address.firstname.truncate(60, omission: '')
    retVal[:email] = order.email.truncate(50, omission: '')
    retVal[:phone] = address.phone
    retVal[:surl] = urls[:surl]
    retVal[:furl] = urls[:furl]
    digest = Digest::SHA2.new(512)
    digest << retVal[:key] << "|"
    PAYMENT_DIGEST_KEYS.each do |key|
      digest << (retVal[key.to_sym] || "") << "|"
    end
    digest << key_salt[:salt]
    retVal[:hash] = digest.hexdigest
    retVal[:lastname] = address.lastname.truncate(20, omission: '')
    retVal[:address1] = address.address1.truncate(100, omission: '')
    retVal[:address2] = address.address2.truncate(100, omission: '')
    retVal[:city] = address.city.truncate(50, omission: '')
    retVal[:state] = address.state.name.truncate(50, omission: '')
    retVal[:country] = address.country.name.truncate(50, omission: '')
    retVal[:zipcode] = address.zipcode.truncate(50, omission: '')
    retVal
  end

  def self.responseHash(order, params)
    source = order.unprocessed_payments.last.source

    verifyVal = {}
    verifyVal[:txnid] = params[:txnid]
    verifyVal[:amount] = params[:amount]
    verifyVal[:productinfo] = params[:productinfo]
    verifyVal[:firstname] = params[:firstname]
    verifyVal[:email] = params[:email]
    verifyVal[:status] = params[:status]
    digest = Digest::SHA2.new(512)
    digest << key_salt[:salt] << "|"
    RESPONSE_DIGEST_KEYS.each do |key|
      digest << (verifyVal[key.to_sym] || "") << "|"
    end
    digest << key_salt[:key]
    verifyHash = digest.hexdigest

    source.update(
      mihpayid: params[:mihpayid],
      mode: params[:mode],
      status: params[:status],
      responseHash: params[:hash],
      verifyHash: verifyHash,
      error: params[:error],
      error_message: params[:error_Message],
      bankcode: params[:bankcode],
      pg_type: params[:PG_TYPE],
      bank_ref_num: params[:bank_ref_num],
      unmappedstatus: params[:unmappedstatus],
      name_on_card: params[:name_on_card],
      cardnum: params[:cardnum],
      issuing_bank: params[:issuing_bank],
      card_type: params[:card_type],
    )
  end

  private

    def self.key_salt
      {
        key: 'gtKFFx',
        salt: 'eCwWELxi'
      }
    end

    def self.urls
      if Rails.env.development?
        {
          submit: 'https://test.payu.in/_payment',
          surl: 'http://localhost:3000/checkout/update/confirm',
          furl: 'http://localhost:3000/checkout/update/confirm'
        }
      else
        {
          submit: 'https://test.payu.in/_payment',
          surl: 'http://natty.elasticbeanstalk.com/checkout/update/confirm',
          furl: 'http://natty.elasticbeanstalk.com/checkout/update/confirm'
        }
      end
    end

    PAYMENT_DIGEST_KEYS = %w(
      txnid amount productinfo firstname email
      udf1 udf2 udf3 udf4 udf5
      bogus bogus bogus bogus bogus
    )

    RESPONSE_DIGEST_KEYS = %w(
      status bogus bogus bogus bogus bogus
      udf5 udf4 udf3 udf2 udf1
      email firstname productinfo amount txnid
    )
end
