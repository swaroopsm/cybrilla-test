require "./lib/helper"

class Bank

  include Helper

  attr_accessor :ifsc_code

  def request_params
    [ 'ifsc_code' ]
  end

end
