module OOPM
module Instructions

class Integer
  CODE = 0x5A # 'Z' in ASCII
  
  def self.make_into_bytecode int
    natural = int.abs
    bytes = []
    while natural > 0
      bytes.push natural & 0xFF
      natural >>= 8
    end
    
    sign = int < 0 ? 0x80 : 0x0
    if bytes.count < 2**6
      bytecode = [CODE, sign | bytes.count]
    else
      count = bytes.count
      bytecode = [CODE, sign | 0x40 | (count & 0x3F) ]
      count >>= 6
      
      while count > 0
        more_size_bytes = count > 2**7 ? 0x80 : 0
        bytecode.push more_size_bytes | (count & 0x7F)
        count >>= 7
      end
    end
    
    bytecode += bytes
    return bytecode
  end
  
  def self.make_from_bytestream bytestream
    if bytestream.read_byte != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    header = bytestream.read_byte
    sign = header & 0x80
    more_size_bytes = header & 0x40
    count = header & 0x3F
    shift = 6
    
    while more_size_bytes != 0
      header = bytestream.read_byte
      more_size_bytes = header & 0x80
      count |= (header & 0x7F) << shift
      shift += 7
    end
    
    if bytestream.remaining < count
      raise ArgumentError, "bytecode does not contain enough information to process an INTEGER instruction"
    end
    
    natural = self.byte_seq_to_natural_little_endian bytestream.read_bytes count
    
    if sign == 0
      return natural
    else
      return -natural
    end
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