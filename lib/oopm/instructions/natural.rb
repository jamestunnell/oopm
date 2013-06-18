module OOPM
module Instructions

class Natural
  CODE = 0x4E # 'N' in ASCII

  def self.make_bytecode natural
    if natural < 0
      raise ArgumentError, "natural number must be >= 0"
    end
    
    bytes = []
    while natural > 0
      bytes.push natural & 0xFF
      natural >>= 8
    end
    
    count = bytes.count
    more_size_bytes = count > 2**7 ? 0x80 : 0
    
    bytecode = [CODE, more_size_bytes | bytes.count]
    count >>= 7
    
    while count > 0
      more_size_bytes = count > 2**7 ? 0x80 : 0
      bytecode.push more_size_bytes | (count & 0x7F)
      count >>= 7
    end
    
    bytecode += bytes
    return bytecode
  end
  
  def self.read_bytecode bytecode, offset
    if bytecode[offset] != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    offset += 1
    
    more_size_bytes = bytecode[offset] & 0x80
    count = bytecode[offset] & 0x7F
    shift = 7
    offset += 1
    
    while more_size_bytes != 0
      more_size_bytes = bytecode[offset] & 0x80
      count |= (bytecode[offset] & 0x7F) << shift
      shift += 7
      offset += 1
    end
    
    remaining = (bytecode.size - offset)
    if remaining < count
      raise ArgumentError, "bytecode does not contain enough information to process an INTEGER instruction"
    end
    
    natural = self.byte_seq_to_natural_little_endian bytecode[offset, count]
    offset += count
    
    return natural, offset
  end
  
  def self.byte_seq_to_natural_little_endian byte_seq
    natural = 0
    byte_seq.each_index do |n|
      byte = byte_seq[n]
      natural += byte * 256**n
    end
    return natural
  end
end

end
end