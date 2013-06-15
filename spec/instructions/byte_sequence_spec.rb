require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::ByteSequence do
  describe '.make_bytecode' do
    before :all do
      @code = Instructions::ByteSequence::CODE
      
      @cases = [
        [1,2,3],
        [75, 144, 51, 190, 0xFF, 0xFE],
        (1..25).to_a,
        (0..0xFF).step(4).to_a
      ]
      
      @bytecodes = {}
      @cases.each do |bytes|
        @bytecodes[bytes] = Instructions::ByteSequence.make_bytecode bytes
      end
    end
    
    it "should populate first byte of bytecode with the instruction code for a byte sequence" do
      @bytecodes.each do |bytes, bytecode|
        bytecode.first.should eq @code
      end
    end

    it "should add byte for the byte sequence size after the instruction code byte" do
      @bytecodes.each do |bytes, bytecode|
        size_bytecode = Instructions::Natural.make_bytecode(bytes.size)
        bytecode[1, size_bytecode.count].should eq size_bytecode
      end
    end

    it "should add the byte sequence bytes after the sequence size bytecode" do
      @bytecodes.each do |bytes, bytecode|
        size_bytecode = Instructions::Natural.make_bytecode(bytes.size)
        bytecode[(1 + size_bytecode.count)..-1].should eq bytes
      end
    end
  end  
end
