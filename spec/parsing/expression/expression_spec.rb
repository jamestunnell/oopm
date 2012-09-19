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
  
  describe "producing assembly instructions" do
    it "should produce correct assembly from a complicated expression" do
      output = @parser.parse("x = y = (2*x) + 5.power(2)").to_assembly
      
      output.length.should be 4
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[2].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[2].statement_id.should be :y
      output[3].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_REFERENCE
      output[3].statement_id.should be :x
      output[3].operands.length.should be 1
      output[3].operands[0].should be :y
    end
    
    it "should produce assembly from another complicated expression" do
      output = @parser.parse("output = (x = 2) * 3.times(4 * y = 7)").to_assembly
      
      output.length.should be 5
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[0].statement_id.should be :x
      output[0].operands.length.should be 1
      output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[1].statement_id.should be :y
      output[1].operands.length.should be 1
      output[2].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[2].operands.length.should be 3
      output[3].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[3].operands.length.should be 3
      output[4].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[4].statement_id.should be :output
    end    
  end
end
