require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NumberParser do
  before(:each) do
    @number_parser = NumberParser.new
  end

  it "should parse a string containing a number with no decimal" do
    @number_parser.parse('12345').should be_true
  end

  it "should parse a string containing a number with a decimal and both leading and trailing digit(s)" do
    @number_parser.parse('12345.7890').should be_true
  end

  it "should parse a string containing a number with a decimal, trailing digit(s), and no leading digit(s)" do
    @number_parser.parse('.7890').should be_true
  end

  it "should not parse a string containing a number with a decimal, leading digit(s), and no trailing digit(s)" do
    @number_parser.parse('12345.').should be_nil
  end

  it "should not parse an empty string" do
    @number_parser.parse('').should be_nil
  end

  it "should not parse a non-numeric string" do
    @number_parser.parse('abc').should be_nil
  end

  it "should not parse a half-alphabetic, half-numeric string" do
    @number_parser.parse('abc123').should be_nil
    @number_parser.parse('abc123.45').should be_nil
    @number_parser.parse('abc.45').should be_nil
  end

  it "should not parse a half-numeric, half-alphabetic string" do
    @number_parser.parse('123abc').should be_nil
    @number_parser.parse('123.45abc').should be_nil
    @number_parser.parse('.45abc').should be_nil
  end
end
