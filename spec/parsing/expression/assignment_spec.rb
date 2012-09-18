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
    @parser.parse("x = please_do.this(a = b)").should be_true
    @parser.parse("x = no.way 4 + a = 1").should be_true
  end
  
  it "should produce one LIT instruction for simple assignments of literals" do
    right_hands = ["1200", "hello".inspect, :my_symbol.inspect]
    
    right_hands.each do |right_hand|
      output = @parser.parse("x = " + right_hand).to_assembly
      
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[0].operands.length.should be 1      
    end  
  end

  it "should produce one MSG instruction for simple assignments of non-nested expressions" do
    right_hands = ['1 + "hello"', "find.it(:yourself, 0)"]
    
    right_hands.each do |right_hand|
      output = @parser.parse("x = " + right_hand).to_assembly
      
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    end  
  end
  
  it "should produce one LIT and one REF instruction for dual assignment of a literal" do
    right_hands = ["1200", "hello".inspect, :my_symbol.inspect]
    
    right_hands.each do |right_hand|
      output = @parser.parse("one = two = " + right_hand).to_assembly
      
      output.length.should be 2
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_REFERENCE
      output[0].operands.length.should be 1
      output[1].operands.length.should be 1
    end  
  end

  it "should produce one MSG and one MSG instruction for dual assignment of a non-nested expression" do
    right_hands = ['1 + "hello"', "find.it(:yourself)"]

    right_hands.each do |right_hand|
      output = @parser.parse("first = second = " + right_hand).to_assembly
      
      output.length.should be 2
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_REFERENCE
      output[0].operands.length.should be 3
      output[1].operands.length.should be 1
    end
  end

end
