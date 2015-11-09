class ICMC::SystemService < ICMC::ICMCService
  def routes
    {"LS": ls}
  end

  def ls
    publish(@params)
  end
end
