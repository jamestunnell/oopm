module Assembly
  class SendMsg
    attr_reader :assign, :reciever, :method, :args
    
    def initialize assign, reciever, method, args
      @assign = assign
      @reciever = reciever
      @method = method
      @args = args
    end
    
    def to_s
      output = ""
      
      if !@assign.empty?
        output += "#{@assign} = "
      end
      
      output += "send_msg(#{@reciever},#{@method}"
      
      @args.each do |arg|
        output += ", #{arg}"
      end
      
      output += ")"
      return output
    end
  end
end
