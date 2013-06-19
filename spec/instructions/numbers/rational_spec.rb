require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Instructions::Rational do
  describe '.make_bytecode' do
    before :all do
      @cases = [ 25,577,-4122,8**50,1 ]
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      @cases.each do |numerator|
        @cases.each do |denominator|
          rational = Rational(numerator, denominator)
          bytecode = Instructions::Rational.make_into_bytecode rational
          stream = Streams::ArrayStream.new bytecode
          rational2 = Instructions::Rational::make_from_bytestream(stream)
          rational2.should eq rational
        end
      end
    end
  end  
end
