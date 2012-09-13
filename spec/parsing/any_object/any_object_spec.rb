require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::AnyObjectParser do
  before(:each) do
    @parser = OOPM::Parsing::AnyObjectParser.new
  end
  
  it "should parse valid numbers" do
    @parser.parse('12345').should be_true
    @parser.parse('12345.7890').should be_true
    @parser.parse('.7890').should be_true
  end

  it "should parse valid names" do
    @parser.parse('abc123').should be_true
    @parser.parse('abc_123').should be_true
    @parser.parse('_abc123').should be_true
  end

  it "should parse valid string literals" do
    @parser.parse('"hello world"').should be_true
    @parser.parse('"\\"hello world\\""').should be_true
    @parser.parse("'hello world'").should be_true
    @parser.parse("'\\'hello world\\''").should be_true
  end  
end
