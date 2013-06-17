require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Instructions::Real do
  describe '.make_bytecode' do
    before :all do
      @code = Instructions::Real::CODE
      
      @cases = {
        0.0 => [0,0],
        1.0 => [1,0],
        -1.0 => [-1,0],
        -123.456 => [-123456,-3],
        123.456 => [123456,-3],
        54321.12345e25 => [5432112345, 20],
        3.540403903089944e-79 => [3540403903089944, -94],
        8.288353845208355e-153 => [8288353845208355, -168],
        2207.045676704321 => [2207045676704321, -12],
        981.7120701740752 => [9817120701740752, -13],
        7.659372962310898e+50 => [7659372962310898, 35],
        5.9261103964355464e-09 => [59261103964355464, -25],
       }
      
      @bytecodes = {}
      @cases.each do |real, parts|
        @bytecodes[real] = Instructions::Real.make_bytecode real
      end
    end
    
    it "should put the mantissa (significand) in first part" do
      @bytecodes.each do |real, bytecode|
        significand = @cases[real][0]
        significand_bytecode = Instructions::Integer.make_bytecode significand
        bytecode.size.should be > significand_bytecode.size
        bytecode[1,significand_bytecode.size].should eq significand_bytecode
      end
    end
    
    it "should put the exponent after the mantissa (significand)" do
      @bytecodes.each do |real, bytecode|
        significand = @cases[real][0]
        significand_bytecode = Instructions::Integer.make_bytecode significand
        exponent = @cases[real][1]
        exponent_bytecode = Instructions::Integer.make_bytecode exponent
        bytecode.size.should be == (1 + significand_bytecode.size + exponent_bytecode.size)
        bytecode[significand_bytecode.size + 1, exponent_bytecode.size].should eq exponent_bytecode
      end
    end
  end  
end
