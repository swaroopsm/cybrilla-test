require "net/http"

class Requester

  attr_accessor :options, :url

  def process
    uri = URI(@url)
    res = Net::HTTP.post_form(uri, 'params' => { :transaction => @transaction.hashify })
  end

end
