require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Instructions::Complex do
  describe '.make_bytecode' do
    before :all do
      @cases = [ 25.5, 367, -11.89, 41**200, 2.246e10 ]
    end
    
    it "should produce bytecode that can be read to get back the original value" do
      @cases.each do |real|
        @cases.each do |imag|
          complex = Complex(real, imag)
          bytecode = Instructions::Complex.make_into_bytecode complex
          stream = Streams::ArrayStream.new bytecode
          complex2 = Instructions::Complex::make_from_bytestream(stream)
          complex2.should eq complex
        end
      end
    end
  end  
end
