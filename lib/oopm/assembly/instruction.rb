module OOPM
module Assembly

class Instruction

  INSTRUCTION_LITERAL = :Literal
  INSTRUCTION_SEND_MSG = :SendMsg
  INSTRUCTION_REFERENCE = :Reference

  attr_reader :statement_id, :instruction, :operands

  def initialize instruction, operands, statement_id=:""
    @statement_id = statement_id.empty? ? Util::UniqueName.new_name.to_sym : statement_id
    @instruction = instruction
    
    raise ArgumentError, "operands argument #{operands} not an array" if (operands.class != Array)
    @operands = operands
    
    operands.each do |operand|
      if operand.kind_of? String
      elsif operand.kind_of? Symbol
      elsif operand.kind_of? Numeric
      elsif operand.kind_of? Hash
      elsif operand.kind_of? Array
      else
        raise ArgumentError, "operand #{operand} is not a literal object type"
      end
    end
    
  end

  def to_s
    "#{@statement_id}: #{@instruction} #{@operands}"
  end
end

end
end
