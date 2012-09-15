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
end
