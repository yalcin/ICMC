require "base64"
require "json"

module ICMC
  class CommandParser
    FUNC_REGEX = /(.*)\((.*)\)/
    getter command_string, command, params, cmd_arr
    # sample messages
    # NGINX HOST CREATE BASE64_ENCODED(JSON ARGS)
    # NGINX HOST DESTROY ARGS
    # NGINX HOST ENABLE ARGS
    # NGINX STATUS CONTAINER_NAME
    # NGINX STATUS ALL
    # NGINX HOST LIST

    FUNCTIONS = {
      "ENCODED": "Base64.encode",
      # "DECODE": "Base64.decode",
      "PLAIN": "String.new",
    }

    def initialize(@command_string, @params = [] of String)
      parse_command(@command_string)
    end

    def parse
      # command = walk_in_command(@command.strip.split(' '))
      # case command.size
      # when 0, 1
      #   raise Exception.new('eror')
      # else
      #
      #   elemanlari_gez_fonksiyon_ara_islenmis_olarak_yeni_array_olustur
      #   @service = command[0]
      # when 2
      # @service, @action = command
      # when 3
      #   @service, @action, @verb, args =
      #   @args = parse_args(args)
      # end
    end

    private def parse_command(cmd : String)
      parsed_command = cmd.strip.split(' ')
      if parsed_command.size == 1
        @command = parsed_command.shift
      elsif parsed_command.size > 1
        @command = parsed_command.delete_at(0)
        @params = apply_icmc_fun(parsed_command)
      else
        raise Exception.new("Syntax Error")
      end
    end

    private def apply_icmc_fun(cmd : Array)
      cmd.map { |ele|
        if has_valid_func?(ele)
          parse_args(ele)
        else
          ele
        end
      }
    end

    protected def parse_args(args : String)
      if has_valid_func?(args)
        cmd_args = parse_cmd_args(args)

        fn_name = cmd_args[1]
        fn_args = cmd_args[2]

        _a = case fn_name
             when "ENCODED"
               Base64.decode_string(fn_args)
             when "PLAIN"
               fn_args
             else
               raise Exception.new("CMD ARGS function does not found TODO: fonksiyon listesini goruntule")
             end
      else
        args
      end
      # FUNCTIONS.each do |name, fn|
      #   if(args =~ /#{name}/)
      #     {{ puts(Base64.encode("dddd")) }}
      #     # {{ "#{fn}(#{fn_args})" }}
      #   end
      # end
    end

    protected def parse_cmd_args(cmd_args)
      cmd_args.split(FUNC_REGEX)
    end

    protected def has_valid_func?(cmd_args)
      cmd_args =~ FUNC_REGEX ? true : false
    end

    # macro define_icmc_functions(name, )
  end
end
