module OOPM
module Assembly
  
class Literal < AssemblyStatement
  
  attr_reader :value
  
  def initialize value, statement_id=""
    @value = value
    
    super INSTRUCTION_LITERAL, [@value], statement_id
  end
  
  #def to_s
  #  output = ""
  #  
  #  if !@assign.empty?
  #    output += "#{@assign} = "
  #  end
  #  
  #  output += "send_msg(#{@reciever},#{@method}"
  #  
  #  @args.each do |arg|
  #    output += ", #{arg}"
  #  end
  #  
  #  output += ")"
  #  return output
  #end
end

end
end