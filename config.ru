require "rack"
require "./lib/transaction"

class Serve

  def self.call(env)
    request = Rack::Request.new env

    if request.post?
      @transaction = Transaction.new
      @transaction.build_from_params request.params
      valid = @transaction.valid?

      response = valid ? @transaction.print : "auth failed.."

      if valid
        return [ 200, {"Content-Type" => "text/plain"}, [ response ] ]
      else
        return [ 403, {"Content-Type" => "text/plain"}, [ response ] ]
      end
    else
      return [ 404, {"Content-Type" => "text/plain"}, [ "Not Found" ] ]
    end
  end

end

run Serve
