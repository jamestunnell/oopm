require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::Natural do
  describe '.make_bytecode' do
    before :all do
      @significands = {
        0x12 => [0x12],
        0x1234 => [0x12, 0x34],
        0x714701 => [0x71, 0x47, 0x01],
        0x123 => [0x1, 0x23],
        0x0 => [0x0],
        0x847104A128DD => [0x84, 0x71, 0x04, 0xA1, 0x28, 0xDD]
      }
      
      @bytecodes = {}
      @significands.each do |natural, significand_bytes|
        @bytecodes[natural] = Instructions::Natural.make_bytecode natural
      end
    end
    
    it "should create bytecode that starts with the byte #{Instructions::Natural::CODE}" do
      @bytecodes.each do |natural, bytecode|
        bytecode.first.should eq Instructions::Natural::CODE
      end
    end

    it "should create bytecode that with second byte that describes number of significand bytes" do
      @bytecodes.each do |natural, bytecode|
        bytecode[1].should eq @significands[natural].count
      end
    end

    it "should create significand bytes within the bytecode that match the expected" do
      @bytecodes.each do |natural, bytecode|
        bytecode[2...bytecode.count].should eq @significands[natural]
      end
    end
  end  
end
