require "rack"
require "./lib/transaction"

class Serve

  def self.call(env)
    @transaction = Transaction.new
    request = Rack::Request.new env
    p request.params

    [ 200, {"Content-Type" => "text/plain"}, [@transaction.process] ]
  end

end

run Serve
