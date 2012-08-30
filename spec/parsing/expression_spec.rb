require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpressionParser do
  before(:each) do
    @parser = ExpressionParser.new
    @object_strings = [ '1', 'hello', "\"hello\""]
  end
  
  it "should not parse an empty string" do
    @parser.parse('').should be_nil
  end

  it "should parse bare object" do
    @object_strings.each do |object_string|
      @parser.parse(object_string).should be_true
    end
  end

  it "should parse a grouped object" do
    @object_strings.each do |object_string|
      @parser.parse('(' + object_string + ')').should be_true
    end
  end
  
  it "should not parse a half-grouped object" do
    @object_strings.each do |object_string|
      @parser.parse('(' + object_string).should be_nil
    end
  end
  
  it "should not parse a half-nested grouped object" do
    @object_strings.each do |object_string|
      @parser.parse('((' + object_string + ')').should be_nil
    end
  end
  
  it "should parse a method call with no arguments" do
    @object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing()').should be_true
      @parser.parse(object_string + '.do_nothing').should be_true
    end
  end

  it "should not parse a method call where there are spaces between the . and method name" do
    @object_strings.each do |object_string|
      @parser.parse(object_string + '. do_nothing()').should be_nil
      @parser.parse(object_string + '. do_nothing').should be_nil
    end
  end

  it "should not parse a method call where there are spaces between the method name and ()" do
    @object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing ()').should be_nil
    end
  end
  
  it "should parse a method call with one argument" do
    @object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing(123)').should be_true
      @parser.parse(object_string + '.do_nothing( 123 )').should be_true
    end
  end

  it "should parse a method call with argument list" do
    @object_strings.each do |reciever|
      arg_list = ""
      @object_strings.each do |object_string|
        if arg_list.empty?
          arg_list << object_string
        elsif
          arg_list << " , #{object_string} "
        end
      end
      
      @parser.parse("#{reciever}.do_nothing(#{arg_list})").should be_true
    end
  end
  
  #it "should parse a binary operation" do
  #  @parser.parse('1 + 2').should be_true
  #end
  
  #it "should parse a grouped binary operation" do
  #  @parser.parse('(1 + 2)').should be_true
  #end
  
end
