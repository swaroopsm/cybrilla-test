require "date"
require 'digest/sha1'
require "./lib/helper"
require "./lib/encryptor"

class Transaction

  include Helper
  include Encryptor

  attr_accessor :amount, :date, :merchant_transaction_ref, :payment_gateway_merchant_reference,
                :bank, :account, :payload_with_sha, :payload_to_pg

  def initialize
    @date = Date.today.to_s
  end

  def process
    return "From Transaction"
  end

  def request_params
    [ 'amount', 'date', 'merchant_transaction_ref', 'payment_gateway_merchant_reference' ]
  end

  def prepare_string
    stmt = [ @bank.stringify, @account.stringify, self.stringify ]
    prepared_stmt = stmt.flatten.join("|")
    sha = Digest::SHA1.hexdigest(prepared_stmt)

    @payload_with_sha = [stmt, "hash=#{sha}"].join("|")
  end

  def hashify
    self.encrypt(@payload_with_sha)
  end

  def unhashify
    self.decrypt(@payload_with_pg)
  end

end
