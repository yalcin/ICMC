require "./spec_helper"

class NamelessService < ICMC::ICMCService
end

class ParselessService < ICMC::ICMCService
end

describe ICMC::ICMCService do
  it "raise if name undefined" do
    expect_raises do
      NamelessService.new
    end
  end

  # it "raise if parse method undefined" do
  #   expect_raises do
  #     ParselessService.new.parse("")
  #   end
  # end

  it "works" do
    true.should eq(true)
  end
end
