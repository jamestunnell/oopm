module OOPM
module Assembly
  
class AssemblyInstruction
  
  INSTRUCTION_LITERAL = :Literal
  INSTRUCTION_SEND_MSG = :SendMsg
  
  attr_reader :statement_id, :instruction, :operands
  
  def initialize instruction, operands, statement_id=""
    @statement_id = statement_id.empty? ? Util::UniqueName.new_name : statement_id
    @instruction = instruction
    @operands = operands
  end
  
  def to_s
    "#{@statement_id}: #{@instruction} #{@operands}"
  end
end

end
end
