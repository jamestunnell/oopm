module OOPM
module Instructions

class Natural
  CODE = 0x4E # 'N' in ASCII
  MIN = 0
  MAX = 256 ** 256
  RANGE = MIN..MAX
  
  def self.make_bytecode natural
    unless RANGE.include? natural
      raise ArgumentError, "RANGE does not include #{natural}"
    end
    
    if natural == 0
      return [CODE, 1, 0]
    end
    
    bytes = []
    
    while natural > 0
      bytes.push natural & 0xFF
      natural >>= 8
    end
    
    return [CODE, bytes.size] + bytes.reverse
  end
  
  def self.read_bytecode bytecode, offset
    if bytecode[offset] != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    offset += 1
    
    nat_size = bytecode[offset]
    offset += 1

    remaining = (bytecode.size - offset)    
    if remaining < nat_size
      raise ArgumentError, "bytecode does not contain enough information to process a NATURAL instruction"
    end
    
    natural = self.byte_seq_to_natural bytecode[offset, nat_size]
    offset += nat_size
    
    return natural, offset
  end
  
  def self.byte_seq_to_natural byte_seq
    natural = 0
    byte_seq.each_index do |n|
      byte = byte_seq[n]
      natural += byte * 256**(byte_seq.size - 1 - n)
    end
    return natural
  end
end

end
end