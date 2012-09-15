require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do

  object_strings = [ '1', 'hello', "\"hello\""]
  expression_strings = ["my_obj", "1", '"hello world"', "1.times", "no.way()", "(1+2)", "(5 / 5)"]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
  end

  it "should not parse an empty string" do
    @parser.parse('').should be_nil
  end

  describe "parsing bare objects" do
    it "should parse bare object" do
      object_strings.each do |object_string|
        @parser.parse(object_string).should be_true
      end
    end
  end

  describe "parsing nested expressions" do

    it "should parse any expression used in method reciever and/or method argument" do
      expression_strings.each do |l_expr_str|
        expression_strings.each do |r_expr_str|
          @parser.parse(l_expr_str + ".does(" + r_expr_str + ")").should be_true
        end
      end
    end

    it "should parse any expression used as left/right-hand operand in a binary operation" do
      expression_strings.each do |l_expr_str|
        expression_strings.each do |r_expr_str|
          @parser.parse(l_expr_str + " + " + r_expr_str).should be_true
        end
      end
    end

  end
end
