require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Assembly::AssemblyInstruction do
  it "should populate statement_id when not specified" do
    a = OOPM::Assembly::AssemblyInstruction.new OOPM::Assembly::AssemblyInstruction::INSTRUCTION_LITERAL, []
    a.statement_id.empty?.should be_false
  end

  it "should populate operands as specified" do
    a = OOPM::Assembly::AssemblyInstruction.new OOPM::Assembly::AssemblyInstruction::INSTRUCTION_LITERAL, []
    a.operands.empty?.should be_true
    
    a = OOPM::Assembly::AssemblyInstruction.new OOPM::Assembly::AssemblyInstruction::INSTRUCTION_LITERAL, ["x", "y", "z"]
    a.operands.length.should be 3
    a.operands[0].should eq("x")
    a.operands[1].should eq("y")
    a.operands[2].should eq("z")
  end
end
