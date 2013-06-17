require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::Integer do
  describe '.make_bytecode' do
    before :all do
      @code = Instructions::Integer::CODE
      
      @cases = [
        0,
        1,
        -1,
        1234,
        20000006510000000002222,
        22**110,
        -10,
        -51049199999,
      ]
      
      @bytecodes = {}
      @cases.each do |int|
        @bytecodes[int] = Instructions::Integer.make_bytecode int
      end
    end
    
    it "should populate first byte of bytecode with the instruction code for a byte sequence" do
      @bytecodes.each do |int, bytecode|
        bytecode.first.should eq @code
      end
    end

    it "should add byte for the sign after the instruction code byte" do
      @bytecodes.each do |int, bytecode|
        sign_byte = bytecode[1]
        if int >= 0
          sign_byte.should eq 0
        else
          sign_byte.should eq 1
        end
      end
    end

    it "should add the magnitude (as a natural) after the sign byte" do
      @bytecodes.each do |int, bytecode|
        results = Instructions::Natural.read_bytecode bytecode, 2
        results[0].should eq int.abs
      end
    end
  end  
end
