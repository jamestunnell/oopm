module OOPM
module Assembly
  
class Literal < Instruction
  
  attr_reader :value
  
  def initialize value, statement_id=:""
    @value = value
    
    super INSTRUCTION_LITERAL, [@value], statement_id
  end
  
end

end
end
