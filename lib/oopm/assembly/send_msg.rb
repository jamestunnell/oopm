module OOPM
module Assembly
  
class SendMsg < AssemblyStatement
  
  attr_reader :reciever, :method, :args
  
  def initialize reciever, method, args, statement_id=""
    @reciever = reciever
    @method = method
    @args = args
    
    super INSTRUCTION_SEND_MSG, [reciever, method] + args, statement_id
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