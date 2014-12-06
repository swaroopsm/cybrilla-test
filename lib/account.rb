require "./lib/helper"

class Account
  
  include Helper

  attr_accessor :number

  def request_params
    [ 'number' ]
  end

end
