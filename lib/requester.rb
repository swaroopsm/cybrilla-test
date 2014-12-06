require "net/http"

class Requester

  attr_accessor :transaction, :url, :params

  def initialize
    @params = {}
  end

  def process
    uri = URI(@url)
    @transaction.hashify
    @params['payload'] = @transaction.payload_with_pg
    @params['nonce'] = @transaction.nonce

    response = Net::HTTP.post_form(uri, @params)
  end

end
