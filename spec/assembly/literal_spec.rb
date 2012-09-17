require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Assembly::Literal do
  it "should take any value specified" do
    a = OOPM::Assembly::Literal.new "baby"
    a.value.should eq("baby")

    a = OOPM::Assembly::Literal.new 2
    a.value.should eq(2)
  end

  it "should have operands that contain only the value" do
    a = OOPM::Assembly::Literal.new "baby"
    a.operands.length.should be 1
    a.operands[0].should eq("baby")

    a = OOPM::Assembly::Literal.new 2
    a.operands.length.should be 1
    a.operands[0].should eq(2)
  end
end
