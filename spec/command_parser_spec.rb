require "./spec_helper"

cmd = "TEST COMMAND PARSER ENCODED(QVJHUw==)"
cmd_plain_args = "TEST COMMAND PARSER PLAIN(ARGS)"

parser = ICMC::CommandParser.new(cmd)
parser_plain = ICMC::CommandParser.new(cmd)


class TestService < ICMC::ICMCService
  INSTANCE = new($redis, [] of String)
  def routes
    {"COMMAND": "_command"}
  end

  def _command
    `ls`
  end
end

$ROUTES = { "TEST": TestService.new($redis, parser.params)  } of String => ICMC::ICMCService
describe ICMC::CommandParser do
  it "command must be test" do
    parser.command.should eq("TEST")
  end

  it "must have 3 elements in params array" do
    parser.params.size.should eq(3)
  end

  it "should run _command method when invoke the class and should return COMMAND" do
    r = $ROUTES["TEST"] as ICMC::ICMCService
    puts r.call_method("_command")
    # puts r.routes as Hash
  end

  #
  #
  # it "service name must be TEST" do
  #   parser.service.should eq("TEST")
  # end
  #
  # it "action must be COMMAND" do
  #   parser.action.should eq("COMMAND")
  # end
  #
  # it "verb must be PARSER" do
  #   parser.verb.should eq("PARSER")
  # end
  #
  # it "args must decode from base64 and should decoded to 'ARGS'" do
  #   parser.args.should eq("ARGS")
  # end
  #
  # it "when args sent in plain" do
  #   parser_plain.args.should eq("ARGS")
  # end

  # it "raise if name undefined" do
  #   expect_raises do
  #     NamelessService.new
  #   end
  # end
  #
  # it "raise if parse method undefined" do
  #   expect_raises do
  #     ParselessService.new.parse("")
  #   end
  # end
  #
  # it "works" do
  #   true.should eq(true)
  # end
end
