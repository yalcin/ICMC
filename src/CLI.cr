require "redis"
require "./ICMC/version"

class ICMC::CLI
  def initialize
    puts "ICMC #{ICMC::VERSION} Command Line Interface"

    @redis = Redis.new

    subscribe

    while true
      print "# "
      parse(gets('\n'))
    end
  end

  def subscribe
    @redis.subscribe("ICMC") do |on|
      on.message do |channel, message|
        puts message
      end
    end
  end

  def parse(cmd : String)
    cmd = cmd.strip
    if cmd == ".q"
      exit(1)
    end

    @redis.publish("ICMC", cmd)
  end

  def parse(cmd : Nil)
    true
  end
end

ICMC::CLI.new
