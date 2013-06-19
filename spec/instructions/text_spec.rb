require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::Text do
  describe '.make_bytecode and .read_bytecode' do
    before :all do
      @cases = [ "abc", "Hello World!" ]
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      Instructions::Text::ENCODING_MAP.keys.each do |encoding|
        @cases.each do |str|
          str.encode!(encoding)
          bytecode = Instructions::Text.make_into_bytecode str
          bytestream = Streams::ArrayStream.new bytecode
          str2 = Instructions::Text::make_from_bytestream bytestream
          str2.should eq str
        end
      end
    end
  end  
end
