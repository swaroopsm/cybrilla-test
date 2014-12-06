require "date"
require "erb"
require 'digest/sha1'
require "./lib/helper"
require "./lib/encryptor"
require "./lib/bank"
require "./lib/account"

class Transaction

  include Helper
  include Encryptor

  attr_accessor :amount, :date, :merchant_transaction_ref, :payment_gateway_merchant_reference, :hash,
                :bank, :account, :payload_with_sha, :payload_with_pg, :nonce, :valid

  def initialize
    @date = Date.today.to_s
  end

  def prettify_date
    Date.parse(self.date).strftime("%B %d, %Y")
  end

  def valid?
    @valid
  end

  def request_params
    [ 'amount', 'date', 'merchant_transaction_ref', 'payment_gateway_merchant_reference' ]
  end

  def prepare_string
    stmt = [ @bank.stringify, @account.stringify, self.stringify ]
    prepared_stmt = stmt.flatten.join("|")
    @hash = Digest::SHA1.hexdigest(prepared_stmt)

    @payload_with_sha = [stmt, "hash=#{@hash}"].join("|")
  end

  def hashify
    self.prepare_string
    @payload_with_pg, @nonce = self.encrypt(@payload_with_sha)
  end

  def unhashify
    self.decrypt(@payload_with_pg)
  end

  def build_from_params(params)
    @nonce = params['nonce']
    @payload_with_pg = params['payload']
    decrypted = self.unhashify
    unstringified = self.unstringify(decrypted)

    self.request_params.each{ |p| self.instance_variable_set("@#{p}".to_sym, unstringified[p]) }

    @bank = Bank.new
    @bank.request_params.each{ |p| @bank.instance_variable_set("@#{p}".to_sym, unstringified[p]) }

    @account = Account.new
    @account.request_params.each{ |p| @account.instance_variable_set("@#{p}".to_sym, unstringified[p]) }

    self.prepare_string
    @valid = @hash === unstringified['hash'] ? true : false
  end

  def print
    transaction = self
    template = File.read File.expand_path("../templates/transaction.erb", __FILE__)
    renderer = ERB.new(template)

    renderer.result(binding)
  end

end
