require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do

  object_strings = [ '1', 'hello', "\"hello\""]
  expression_strings = ["my_obj", "1", '"hello world"', "1.times", "no.way()", "(1+2)", "(5 / 5)", "5.times[1,2,3]", "this.should = :be_okay"]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
  end

  describe "parsing arrays" do
    it "should parse an array containing any object(s)" do
      input = "["
      object_strings.each do |object_string|
        input += "#{object_string}, "
      end
      input += "]"
      @parser.parse(input).should be_true
    end

    it "should parse an array containing any expression(s)" do
      input = "["
      expression_strings.each do |expression_string|
        input += "#{expression_string}, "
      end
      input += "]"
      @parser.parse(input).should be_true
    end
  end

  describe "parsing hashes" do
    it "should parse a hash containing any object(s)" do
      input = "{"
      object_strings.each do |key|
        object_strings.each do |val|
          input += "#{key} => #{val}, "
        end
      end
      input += "}"
      @parser.parse(input).should be_true
    end

    it "should parse a hash containing any expression(s)" do
      input = "{"
      expression_strings.each do |key|
        expression_strings.each do |val|
          input += "#{key} => #{val}, "
        end
      end
      input += "}"
      @parser.parse(input).should be_true
    end
  end
  
  describe "outputting assembly from parsed array" do
    it "should produce one LIT instruction from parsing an array with only literals" do
      output = @parser.parse("[1, 'hello', :goodbye]").to_assembly
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[0].operands.length.should be 1
    end

    it "should produce one LIT and one MSG instruction from parsing an array with at most one method call" do
      output = @parser.parse("[1, 'hello'.length, :goodbye]").to_assembly
      output.length.should be 2
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[0].operands.length.should be 2
      output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[1].operands.length.should be 1
    end
  end

  describe "outputting assembly from parsed hash" do
    it "should produce one LIT instruction from parsing a hash with only literals" do
      output = @parser.parse("{1 => 'this', 'hello' => 215, :goodbye => 'world'}").to_assembly
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[0].operands.length.should be 1
    end

    it "should produce one LIT and one MSG instruction from parsing a hash with at most one method call" do
      output = @parser.parse("{1 => 'this', 'hello'.length => 500, :goodbye => 'world'}").to_assembly
      output.length.should be 2
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[0].operands.length.should be 2
      output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[1].operands.length.should be 1
    end
  end
end
