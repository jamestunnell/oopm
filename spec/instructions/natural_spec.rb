require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::Natural do
  describe '.make_bytecode' do
    before :all do
      @cases = [
        0x12,
        0x1234,
        0x714701,
        0x123,
        0x0,
        0x847104A128DD,
        31**300,
        57**2100,
      ]
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      @cases.each do |natural|
        bytecode = Instructions::Natural.make_into_bytecode natural
        stream = ArrayStream.new bytecode
        natural2 = Instructions::Natural::make_from_bytestream(stream)
        natural2.should eq natural
      end
    end
  end  
end
