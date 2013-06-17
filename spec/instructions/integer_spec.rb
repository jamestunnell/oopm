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

    it "should add byte for the sign and size after the instruction code byte" do
      @bytecodes.each do |int, bytecode|
        #check sign bit
        second_byte = bytecode[1]
        if int >= 0
          (second_byte & 0x80).should eq 0
        else
          (second_byte & 0x80).should eq 0x80
        end
        
        #check size bits
        (bytecode.size - 2).should eq(second_byte & 0x7F)
      end
    end
    
    it "should add the magnitude after the sign/size byte" do
      @bytecodes.each do |int, bytecode|
        bc = bytecode.clone
        bc[0] = Instructions::Natural::CODE
        bc[1] &= 0x7F
        
        results = Instructions::Natural.read_bytecode bc, 0
        results[0].should eq int.abs
      end
    end
  end  
end
