require 'pry'

module OOPM
module Processing

class BytecodeProcessor
  attr_reader :results
  
  def initialize
    @results = []
  end
  
  def process_bytecode bytes, offset
    cur = bytes[offset]
    
    case cur
    when Instructions::Natural::CODE
      results = Instructions::Natural.read_bytecode bytes, offset
      natural = results[0]
      offset = results[1]
      
      @results.push natural
    when Instructions::ByteSequence::CODE
      results = Instructions::ByteSequence.read_bytecode bytes, offset
      bytes = results[0]
      offset = results[1]
      
      @results.push bytes
    else
      raise ArgumentError, "unrecognized instruction code #{cur}"
    end
    
    return offset
  end
end

end
end