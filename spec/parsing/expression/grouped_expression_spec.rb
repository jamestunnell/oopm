require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do
  object_strings = [ '1', 'hello', "\"hello\""]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
    @parser.root = :grouped_expression
  end

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
  
  it "should produce the same assembly instructions as a non-grouped expression" do
    pairs = {
      "5 + 10" => "(5 + 10)",
      "hello.world(1) + 10" => "(hello.world(1) + 10)"
    }
    
    pairs.each do |a, b|
      @parser.root = :expression
      nongrouped = @parser.parse(a).to_assembly
      @parser.root = :grouped_expression
      grouped = @parser.parse(b).to_assembly
      
      grouped.length.should eq(nongrouped.length)
      
      for i in 0...grouped.length do
        grouped[i].instruction.should eq(nongrouped[i].instruction)
        grouped[i].operands.length.should eq(nongrouped[i].operands.length)
        
        # skip check of first operand (might be unique name ID, so they won't match)
        for j in 1...grouped[i].operands.length do
          grouped[i].operands[j].should eq(nongrouped[i].operands[j])
        end        
      end
    end
  end

end
