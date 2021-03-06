require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Instructions::Real do
  describe '.make_bytecode' do
    before :all do
      @code = Instructions::Real::CODE
      
      @cases = [
        0.0, 1.0, -1.0, -123.456, 123.456,
        54321.12345e25,
        3.540403903089944e-79,
        8.28835384520836e-153,
        2207.045676704321,
        981.7120701740,
        7.659372962310898e+50,
        5.9261103964e-09,
       ]
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      @cases.each do |real|
        bytecode = Instructions::Real.make_into_bytecode real
        stream = Streams::ArrayStream.new bytecode
        real2 = Instructions::Real::make_from_bytestream(stream)
        real2.should eq real
      end
    end
  end  
end
