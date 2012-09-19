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

  it "should parse a simple array access" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '[0]').should be_true
      @parser.parse(object_string + '[1,2,3]').should be_true
      @parser.parse(object_string + '[does_nothing.and_more()]').should be_true
    end
  end
  
  it "should parse a chained method call / array access" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '[0].does_it()').should be_true
      @parser.parse(object_string + '.does_it[1,2,3]').should be_true
      @parser.parse(object_string + '[:you].and_me[:are_just_fine]').should be_true
    end
  end

  it "should parse a simple method call (no parenth, no args) followed by an assignment" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing = "okay?"').should be_true
      @parser.parse(object_string + '.do_nothing= this.is_okay()').should be_true
      @parser.parse(object_string + '.do_nothing   =  :just_fine').should be_true
    end
  end

  it "should not parse a simple method call (with parenth) followed by an assignment" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing() = "okay?"').should be_nil
      @parser.parse(object_string + '.do_nothing()= this.is_not_okay()').should be_nil
      @parser.parse(object_string + '.do_nothing()   =  :not_fine').should be_nil
    end
  end
  
  it "should parse a chained method call (last call has no parenth, no args) followed by an assignment" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing(a,b,c).and_more = 5').should be_true
      @parser.parse(object_string + '.do_nothing.and_more[5] = :good_stuff').should be_true
      @parser.parse(object_string + '.do_nothing.and_more("stuff").and_more= best.ever()').should be_true
    end
  end
  
  it "should not parse a chained method call (last call has parenth) followed by an assignment" do
    object_strings.each do |object_string|
      @parser.parse(object_string + '.do_nothing(a,b,c).and_more(2) = 5').should be_nil
      @parser.parse(object_string + '.do_nothing.and_more("stuff")= best.ever()').should be_nil
    end
  end

  it "should produce one MSG instruction with 2 operands from a simple no-arg method call" do
    method_calls = ["you_should.do_this", '3.licks', "the_great.bambi()"]
    
    method_calls.each do |method_call|
      output = @parser.parse(method_call).to_assembly
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[0].operands.length.should be 2
    end
  end
  
  it "should produce one MSG instruction with 4 operands from a simple two-arg method call" do
    method_calls = ["you_should.do_this(:twice,:thrice)", '3.licks("to the center",:of_a_tootsie_pop)', "the_great.bambi(1,2)"]
    
    method_calls.each do |method_call|
      output = @parser.parse(method_call).to_assembly
      output.length.should be 1
      output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
      output[0].operands.length.should be 4
    end
  end
  
  it "should produce two MSG instructions with 3 operands each from a one-arg nested method call" do
    output = @parser.parse("one.time(and.once(:again))").to_assembly
    output.length.should be 2
    output[0].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    output[0].operands.length.should be 3
    output[1].instruction.should be OOPM::Assembly::Instruction::INSTRUCTION_SEND_MSG
    output[1].operands.length.should be 3
  end
end
