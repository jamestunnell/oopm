require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BinaryOperationParser do
  before(:each) do
    @parser = BinaryOperationParser.new
    @numbers = ['123','2000000', '20.62', '.12345']
    @nonnumbers = ['abc123','200000abc', 'abc20.62', 'abc.12345']    
    @operators = ["+", "-", "*", "/", "%", "|", "&", "==", "||", "&&"]
  end

  it "should not parse an empty string" do
    @parser.parse('').should be_nil
  end
  
  it "should parse binary operations when operands are valid numbers" do
    @operators.each do |operand|
      @numbers.each do |lhs|
        @numbers.each do |rhs|
          arg = lhs + ' ' + operand + ' ' + rhs
          @parser.parse(arg).should be_true
        end
      end
    end
  end
  
  it "should not parse binary operations when operands are not valid numbers" do
    @operators.each do |operand|
      @nonnumbers.each do |lhs|
        @nonnumbers.each do |rhs|
          arg = lhs + ' ' + operand + ' ' + rhs
          @parser.parse(arg).should be_nil
        end
      end
    end    
  end
  
  it "should parse binary operations when operands are not seperated by spaces" do
    @operators.each do |operand|
      @numbers.each do |lhs|
        @numbers.each do |rhs|
          arg = lhs + operand + rhs
          @parser.parse(arg).should be_true
        end
      end
    end    
  end
end
