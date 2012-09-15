require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do

  binary_operators = ["+", "-", "*", "/", "%", "||", "&&", "==", "|", "&",
                      "<<", "+=", "-=", "*=", "/=", "&=", "|=", "%=", "**", "//"]
  object_strings = [ '1', 'hello', "\"hello\"", ":my_symbol"]
  expression_strings = ["my_obj", "1", '"hello world"', "1.times", "no.way()", "(1+2)", "(5 / 5)"]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
    @parser.root = :assignment
  end
  
  it "should parse a simple assignment" do
    @parser.parse('a = 1').should be_true
  end

  it "should parse a simple assignment regardless of whitespace" do
    @parser.parse('a=1').should be_true
    @parser.parse("a= \t\n1").should be_true
    @parser.parse("a\t\r\n=       1").should be_true
  end
  
  it "should parse an assignment with any literal object" do
    object_strings.each do |object_string|
      @parser.parse("x = #{object_string}").should be_true
    end
  end

  it "should handle successive assignemnts" do
    @parser.parse("a = b = c").should be_true
    @parser.parse("a = b = 2").should be_true
    @parser.parse("johnny = be_good = 'go go'").should be_true
  end
  
  it "should parse an assignment with any expression" do
    expression_strings.each do |string|
      @parser.parse("x = #{string}").should be_true
    end
  end
  
  it "should parse nested assignments (assignment within an expression on the right-hand side)" do
    @parser.parse("x = 5 + y = 2").should be_true
    @parser.parse("x = do.this(a = b)").should be_true
    @parser.parse("x = no.way 4 + a = 1").should be_true
  end
end
