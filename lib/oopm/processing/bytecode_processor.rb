require 'pry'

module OOPM
module Processing

class BytecodeProcessor
  attr_reader :results
  
  def initialize
    @results = []
    @processing_map = {}
    
    Instructions.constants.each do |sym|
      klass = Instructions.const_get(sym)
      if klass.is_a? Class
        if klass.constants.include?(:CODE) and klass.methods.include?(:read_bytecode)
          code = klass.const_get(:CODE)
          @processing_map[code] = klass.method(:read_bytecode)
        end
      end
    end
  end
  
  def process_bytecode bytes, offset
    cur = bytes[offset]
    
    if @processing_map.has_key? cur
      results = @processing_map[cur].call bytes, offset
      value = results[0]
      offset = results[1]
      
      @results.push value
    else
      raise ArgumentError, "unrecognized instruction code #{cur}"
    end
    
    return offset
  end
end

end
end