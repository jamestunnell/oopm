require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do
  
  binary_operators = ["+", "-", "*", "/", "%", "||", "&&", "==", "=", "|", "&", "<<"]
  object_strings = [ '1', 'hello', "\"hello\""]
  expression_strings = ["my_obj", "1", '"hello world"', "1.times", "no.way()", "(1+2)", "(5 / 5)"]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
    @object_strings = [ '1', 'hello', "\"hello\""]
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

  describe "parsing grouped objects" do
    it "should parse a grouped object" do
      object_strings.each do |object_string|
        @parser.parse('(' + object_string + ')').should be_true
      end
    end
    
    it "should not parse a half-grouped object" do
      object_strings.each do |object_string|
        @parser.parse('(' + object_string).should be_nil
      end
    end
    
    it "should not parse a half-nested grouped object" do
      object_strings.each do |object_string|
        @parser.parse('((' + object_string + ')').should be_nil
      end
    end
  end
  
  describe "parsing method calls" do
    it "should parse a method call with no arguments" do
      object_strings.each do |object_string|
        @parser.parse(object_string + '.do_nothing()').should be_true
        @parser.parse(object_string + '.do_nothing').should be_true
      end
    end

    it "should parse a chained method call with no arguments" do
      object_strings.each do |object_string|
        @parser.parse(object_string + '.do_nothing().and_more').should be_true
        @parser.parse(object_string + '.do_nothing.and_more').should be_true
        @parser.parse(object_string + '.do_nothing.and_more.and_more').should be_true
        @parser.parse(object_string + '.do_nothing().and_more().and_more().and_more().ad_infinitum').should be_true
      end
    end
  
    it "should not parse a method call where there are spaces between the . and method name" do
      object_strings.each do |object_string|
        @parser.parse(object_string + '. do_nothing()').should be_nil
        @parser.parse(object_string + '. do_nothing').should be_nil
      end
    end
  
    it "should not parse a method call where there are spaces between the method name and ()" do
      object_strings.each do |object_string|
        @parser.parse(object_string + '.do_nothing ()').should be_nil
      end
    end
    
    it "should parse a method call with one argument" do
      object_strings.each do |object_string|
        @parser.parse(object_string + '.do_nothing(123)').should be_true
        @parser.parse(object_string + '.do_nothing( 123 )').should be_true
      end
    end
  
    it "should parse a method call with argument list" do
      object_strings.each do |reciever|
        arg_list = ""
        object_strings.each do |object_string|
          if arg_list.empty?
            arg_list << object_string
          elsif
            arg_list << ", #{object_string} "
          end
        end
        
        @parser.parse("#{reciever}.do_nothing(#{arg_list})").should be_true
      end
    end

    it "should parse a chained method call with arguments" do
      object_strings.each do |object_string|
        @parser.parse(object_string + '.do_nothing(a,b,c).and_more').should be_true
        @parser.parse(object_string + '.do_nothing.and_more(1,2,3)').should be_true
        @parser.parse(object_string + '.do_nothing.and_more("stuff").and_more("stuff")').should be_true
        @parser.parse(object_string + '.do_nothing().and_more().and_more().and_more().ad_infinitum').should be_true
      end
    end

  end
  describe "parsing binary operations" do
    it "should parse a binary operation" do
      @parser.parse('1 + 2').should be_true
    end
    
    it "should parse a binary expression regardless of whitespace between operands and operator" do
      @parser.parse('("hello"+"world")').should be_true
      @parser.parse('"a+ b"').should be_true
      @parser.parse('"O +\t\n4"').should be_true
    end
    
    it "should parse a sequence of binary operations" do
      @parser.parse('"no" + " two" + " are alike"').should be_true
      @parser.parse('1 + 2 + " are numbers"').should be_true
      @parser.parse('me + you = "good"').should be_true
      @parser.parse('4-2+ 5 /1').should be_true
    end
    
    it "should parse a binary expression using any valid binary operator" do
      binary_operators.each do |binary_operator|
        @parser.parse("1 #{binary_operator} 2").should be_true
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
