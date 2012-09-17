module OOPM
module Assembly
  
class Reference < Instruction
  
  attr_reader :value
  
  def initialize value, statement_id=""
    @value = value
    
    super INSTRUCTION_REFERENCE, [@value], statement_id
  end
  
end

end
end
