require 'pry'

module OOPM
module Processing

class StreamProcessor
  attr_reader :results
  
  def initialize bytestream
    @bytestream = bytestream
    @results = []
    @processing_map = {}
    
    Instructions.constants.each do |sym|
      klass = Instructions.const_get(sym)
      if klass.is_a? Class
        if klass.constants.include?(:CODE) and klass.methods.include?(:make_from_bytestream)
          code = klass.const_get(:CODE)
          @processing_map[code] = klass.method(:make_from_bytestream)
        end
      end
    end
  end
  
  def process_next
    cur = @bytestream.peek_byte
    
    result = nil
    if @processing_map.has_key? cur
      result = @processing_map[cur].call(@bytestream)
      @results.push result
    else
      raise ArgumentError, "unrecognized instruction code #{cur}"
    end
    
    return result
  end
end

end
end