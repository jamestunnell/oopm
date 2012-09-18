require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::LiteralParser do
  before(:each) do
    @parser = OOPM::Parsing::LiteralParser.new
  end
  
  it "should parse valid numbers" do
    @parser.parse('12345').should be_true
    @parser.parse('12345.7890').should be_true
    @parser.parse('.7890').should be_true
  end

  it "should parse valid symbols" do
    @parser.parse(':abc123').should be_true
    @parser.parse(':abc_123').should be_true
    @parser.parse(':_abc123').should be_true
    @parser.parse(':"123"').should be_true
    @parser.parse(':"+"').should be_true
  end

  it "should parse valid string literals" do
    @parser.parse('"hello world"').should be_true
    @parser.parse('"\\"hello world\\""').should be_true
    @parser.parse("'hello world'").should be_true
    @parser.parse("'\\'hello world\\''").should be_true
  end
  
  it "should produce one LIT assembly instruction with one operand value" do
    values = [17, "hello", :my_symbol123]
    
    values.each do |value|
      output = @parser.parse(value.inspect).to_assembly
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_LITERAL
      output[0].operands.length.should be 1
      output[0].operands[0].should eq(value)
    end
  end
end
