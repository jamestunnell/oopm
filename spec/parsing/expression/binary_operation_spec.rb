require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do

  binary_operators = ["+", "-", "*", "/", "%", "||", "&&", "==", "|", "&",
                      "<<", "+=", "-=", "*=", "/=", "&=", "|=", "%=", "**", "//"]
  object_strings = [ '1', 'hello', "\"hello\""]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
    @parser.root = :binary_operation
  end
  
  it "should parse a simple binary operation" do
    @parser.parse('1 + 2').should be_true
  end

  it "should parse a binary expression regardless of whitespace between operands and operator" do
    @parser.parse('"hello"+"world"').should be_true
    @parser.parse("a+ b").should be_true
    @parser.parse("O +\t\n4").should be_true
  end

  it "should parse a sequence of binary operations" do
    @parser.parse('"no" + " two" + " are alike"').should be_true
    @parser.parse('1 + 2 + " are numbers"').should be_true
    @parser.parse('me + you * "good"').should be_true
    @parser.parse('4-2+ 5 /1').should be_true
  end

  it "should parse a binary expression using any valid binary operator" do
    binary_operators.each do |binary_operator|
      @parser.parse("1 #{binary_operator} 2").should be_true
    end
  end

  it "should produce one MSG instruction for simple binary operation" do
    ["1 + 5", '"Hello" << "World"',"you / me"].each do |input|
      output = @parser.parse(input).to_assembly
      
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[0].operands.length.should be 3
    end
  end

  it "should produce two MSG instructions for binary operation containing a nested simple binary operation" do
    output = @parser.parse("(5 + 5) * 2").to_assembly
    output.length.should be 2
    output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    output[0].operands.length.should be 3
    output[1].operands.length.should be 3
  end

  it "should produce two MSG instructions for a sequence of two binary operations" do
    output = @parser.parse("5 + 5 * 2").to_assembly
    output.length.should be 2
    output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    output[0].operands.length.should be 3
    output[1].operands.length.should be 3
  end
end
