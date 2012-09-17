module OOPM
module Assembly

class SendMsg < Instruction

  attr_reader :reciever, :method, :args

  def initialize reciever, method, args=[], statement_id=:""
    @reciever = reciever
    @method = (method.class == Symbol) ? method : method.to_sym

    raise ArgumentError if (args.class != Array)
    @args = args

    super INSTRUCTION_SEND_MSG, [reciever, method] + args, statement_id
  end

end

end
end
