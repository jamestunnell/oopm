require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::Integer do
  describe '.make_bytecode and .read_bytecode' do
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
        2**5000,
        25**150,
        39**800
      ]
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      @cases.each do |int|
        bytecode = Instructions::Integer.make_into_bytecode int
        bytestream = Streams::ArrayStream.new bytecode
        int_2 = Instructions::Integer::make_from_bytestream bytestream
        int_2.should eq int
      end
    end
  end  
end
