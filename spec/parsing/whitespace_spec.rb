require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WhitespaceParser do
  before(:each) do
    @parser = WhitespaceParser.new
  end

  it "should parse an empty string" do
    @parser.parse("").should be_true
    @parser.parse("").should be_true
  end

  it "should parse a string containing only spaces" do
    @parser.parse(" ").should be_true
    @parser.parse("                                     ").should be_true
  end

  it "should parse a string containing only tabs" do
    @parser.parse("\t").should be_true
    @parser.parse("\t\t\t\t\t\t\t\t\t\t\t\t\t").should be_true
  end
  
  it "should parse a string containing only carriage returns" do
    @parser.parse("\r").should be_true
    @parser.parse("\r\r\r\r\r\r\r\r\r\r\r\r\r").should be_true
  end
  
  it "should parse a string containing only newlines" do
    @parser.parse("\n").should be_true
    @parser.parse("\n\n\n\n\n\n\n\n\n\n\n\n\n").should be_true
  end

  it "should parse a string containing only a combination of any whitespace" do
    @parser.parse(" \t\r\n").should be_true
    @parser.parse("\n \t \r  ").should be_true
  end
  
  it "should not parse a string containing non-whitespace" do
    @parser.parse("abc").should be_nil
    @parser.parse(" abc ").should be_nil
  end
  
end
