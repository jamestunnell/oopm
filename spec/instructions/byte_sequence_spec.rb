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
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      @cases.each do |byte_seq|
        bytecode = Instructions::ByteSequence.make_into_bytecode byte_seq
        bytestream = Streams::ArrayStream.new(bytecode)
        byte_seq2 = Instructions::ByteSequence::make_from_bytestream bytestream
        byte_seq2.should eq byte_seq
      end
    end
  end  
end
