module OOPM
module Assembly
  
class SendMsg < AssemblyInstruction
  
  attr_reader :reciever, :method, :args
  
  def initialize reciever, method, args, statement_id=""
    @reciever = reciever
    @method = (method.class == Symbol) ? method : method.to_sym
    @args = args
    
    super INSTRUCTION_SEND_MSG, [reciever, method] + args, statement_id
  end
  
end

end
end
