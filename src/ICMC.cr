require "redis"
# require "./ICMC/*"
# require "./ICMC/"
require "./ICMC/version"
require "./ICMC/services/ICMC_service"
require "./ICMC/services/system_service"
require "./ICMC/command_parser"

$redis = Redis.new
$ROUTES = {"SYS": ICMC::SystemService.new($redis, [] of String).routes}

module ICMC
  def self.run
    puts "ICMC started"
    $redis.subscribe("ICMC") do |on|
      on.message { |channel, message|
        puts ICMC::CommandParser.new(message)
      }
    end
  end
end

# ICMC.run
