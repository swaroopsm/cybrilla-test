module Helper

  def stringify
    args = []
    self.request_params.each{ |p| args << p + "=" + instance_variable_get("@#{p}").to_s  }

    return args
  end

end
