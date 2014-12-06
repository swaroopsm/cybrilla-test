module Helper

  def stringify
    args = []
    self.request_params.each{ |p| args << p + "=" + instance_variable_get("@#{p}").to_s  }

    return args
  end

  def unstringify(data)
    hash = {}

    data.split("|").each do |d|
      splitted = d.split("=")
      hash[splitted[0].strip] = splitted[1].strip
    end

    hash
  end

end
