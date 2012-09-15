require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::ExpressionParser do
  object_strings = [ '1', 'hello', "\"hello\""]

  before(:each) do
    @parser = OOPM::Parsing::ExpressionParser.new
    @parser.root = :method_call
  end

  it "should parse a method call with no arguments" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing()').should be_true
      @parser.parse(object_string + '.do_nothing').should be_true
    end
  end

  it "should parse a chained method call with no arguments" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing().and_more').should be_true
      @parser.parse(object_string + '.do_nothing.and_more').should be_true
      @parser.parse(object_string + '.do_nothing.and_more.and_more').should be_true
      @parser.parse(object_string + '.do_nothing().and_more().and_more().and_more().ad_infinitum').should be_true
    end
  end

  it "should not parse a method call where there are spaces between the . and method name" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '. do_nothing()').should be_nil
      @parser.parse(object_string + '. do_nothing').should be_nil
    end
  end

  it "should not parse a method call where there are spaces between the method name and ()" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing ()').should be_nil
    end
  end

  it "should parse a method call with one argument" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing(123)').should be_true
      @parser.parse(object_string + '.do_nothing( 123 )').should be_true
    end
  end

  it "should parse a method call with argument list" do
    object_strings.each do |reciever|
      arg_list = ""
      object_strings.each do |object_string|
        if arg_list.empty?
          arg_list << object_string
        elsif
          arg_list << ", #{object_string} "
        end
      end

      @parser.parse("#{reciever}.do_nothing(#{arg_list})").should be_true
    end
  end

  it "should parse a chained method call with arguments" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing(a,b,c).and_more').should be_true
      @parser.parse(object_string + '.do_nothing.and_more(1,2,3)').should be_true
      @parser.parse(object_string + '.do_nothing.and_more("stuff").and_more("stuff")').should be_true
      @parser.parse(object_string + '.do_nothing().and_more().and_more().and_more().ad_infinitum').should be_true
    end
  end
end
