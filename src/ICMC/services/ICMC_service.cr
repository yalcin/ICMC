module ICMC
  class ICMCService
    getter name, channel, redis

    def initialize(@redis, @params)
      # if @name.is_a?(Nil)
      #   raise Exception.new("'name' was not defined")
      # end

      @channel = "ICMC"
      # @redis = redis
    end

    def subscribe
      puts "Subscribed #{@channel}"
      @redis.subscribe(@channel) do |on|
        on.message { |channel, message|
          puts message
        }
      end
    end

    def publish(message)
      @redis.publish(@channel, message)
    end

    # https://github.com/Codcore/amethyst/blob/master/src/amethyst/support/sendable.cr#L18-L37
    macro call_method_macro
      case method
        {% for meth in @type.methods %}
      when "{{meth.name.id}}"
        {{meth.name.id}}
        {% end %}
      end
    end

    def call_method(method)
      call_method_macro
    end

    # def parse(message)
    #   raise Exception.new("child class has no parse method")
    # end
  end
end
