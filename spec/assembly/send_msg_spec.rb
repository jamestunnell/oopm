require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Assembly::SendMsg do
  it "should take expected values for reciever and method" do
    a = OOPM::Assembly::SendMsg.new :x, :do_this
    a.reciever.should eq(:x)
    a.method.should eq(:do_this)
  end

  it "should convert method argument to a symbol if it's not already" do
    a = OOPM::Assembly::SendMsg.new "abc123", "count"
    a.reciever.should eq("abc123")
    a.method.should eq(:count)
  end

  it "should make reciever and method the first two operands" do
    a = OOPM::Assembly::SendMsg.new :x, :do_this
    a.operands.length.should be 2
    a.operands[0].should eq(:x)
    a.operands[1].should eq(:do_this)
  end

  it "should raise ArgumentError if a non-array is passed for args parameter" do
    expect { a = OOPM::Assembly::SendMsg.new :x, :do_this, "okay" }.to raise_error(ArgumentError)
  end

  it "should append any method args to operands" do
    a = OOPM::Assembly::SendMsg.new :x, :do_this, [1,2,3]
    a.operands.length.should be 5
    a.operands[0].should eq(:x)
    a.operands[1].should eq(:do_this)
    a.operands[2].should be 1
    a.operands[3].should be 2
    a.operands[4].should be 3
  end
end
