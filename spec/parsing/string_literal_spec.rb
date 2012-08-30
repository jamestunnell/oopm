require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StringLiteralParser do
  before(:each) do
    @parser = StringLiteralParser.new
    @messages = ["hello world", "What a wonderful world!!!"]
  end
  
  it "should parse basic double-quoted string literals" do
    @messages.each do |message|
      @parser.parse('"' + message + '"').should be_true
    end
  end
  
  it "should parse basic single-quoted string literals" do
    @messages.each do |message|
      @parser.parse("'" + message + "'").should be_true
    end
  end  

  it 'should parse double-quoted string literals containing \"' do
    @messages.each do |message|
      @parser.parse('"\"' + message + '\""').should be_true
    end
  end

  it "should parse single-quoted string literals containing \\\'" do
    @messages.each do |message|
      @parser.parse("'\\\'" + message + "\\\''").should be_true
    end
  end
end
