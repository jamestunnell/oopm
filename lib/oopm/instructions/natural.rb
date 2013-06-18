module OOPM
module Instructions

class Natural
  CODE = 0x4E # 'N' in ASCII

  def self.make_into_bytecode natural
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
  
  def self.make_from_bytestream bytestream
    if bytestream.peek_byte == CODE
      bytestream.read_byte
    else
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    header = bytestream.read_byte
    more_size_bytes = header & 0x80
    count = header & 0x7F
    shift = 7
    
    while more_size_bytes != 0
      header = bytestream.read_byte
      more_size_bytes = header & 0x80
      count |= (header & 0x7F) << shift
      shift += 7
    end
    
    if bytestream.remaining < count
      raise ArgumentError, "bytecode does not contain enough information to process an INTEGER instruction"
    end
    
    natural = self.byte_seq_to_natural_little_endian bytestream.read_bytes(count)
    return natural
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