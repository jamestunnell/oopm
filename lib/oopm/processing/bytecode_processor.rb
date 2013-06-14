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
    
    if cur == Instructions::Natural::CODE
      nat_size = bytes[offset + 1]
      remaining = (bytes.size - offset + 1)
      
      if remaining < nat_size
        raise ArgumentError, "bytestream does not contain enough information to process a NATURAL instruction"
      end
      
      result = 0
      nat_size.times do |n|
        byte = bytes[offset + 2 + n]
        result += byte * 256**(nat_size - 1 - n)
      end
      
      @results.push result
      offset += 2 + nat_size
    end
    
    return offset
  end
end

end
end