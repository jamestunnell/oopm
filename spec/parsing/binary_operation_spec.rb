require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BinaryOperationParser do
  before(:each) do
    @parser = BinaryOperationParser.new
    @objects = ['123', '20.62', '.12345', 'my_object', 'abc123', '__okdoke123']
    @nonobjects = ['abc20.62', 'abc.12345', 'abc 123']
    @operators = ["+", "-", "*", "/", "%", "|", "&", "==", "||", "&&"]
  end

  it "should not parse an empty string" do
    @parser.parse('').should be_nil
  end
  
  it "should parse binary operations when operands are valid objects" do
    @operators.each do |operator|
      @objects.each do |lhs|
        @objects.each do |rhs|
          arg = lhs + ' ' + operator + ' ' + rhs
          @parser.parse(arg).should be_true
        end
      end
    end
  end
  
  it "should not parse binary operations when operands are not valid objects" do
    @operators.each do |operator|
      @objects.each do |lhs|
        @nonobjects.each do |rhs|
          arg = lhs + ' ' + operator + ' ' + rhs
          @parser.parse(arg).should be_nil
        end
      end
    end
    
    @operators.each do |operator|
      @nonobjects.each do |lhs|
        @objects.each do |rhs|
          arg = lhs + ' ' + operator + ' ' + rhs
          @parser.parse(arg).should be_nil
        end
      end
    end    
  end
  
  it "should parse binary operations when operands are not seperated by spaces" do
    @operators.each do |operator|
      @objects.each do |lhs|
        @objects.each do |rhs|
          arg = lhs + operator + rhs
          @parser.parse(arg).should be_true
        end
      end
    end    
  end
end
