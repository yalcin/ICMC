class ICMC::Routes
  INSTANCE = new

  def initialize
    @routes = {} of String => ICMC::ICMCService
  end

  def add(route)
    @routes << route
  end
end
