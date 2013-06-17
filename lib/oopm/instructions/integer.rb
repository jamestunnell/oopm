module OOPM
module Instructions

class Integer
  CODE = 0x5A # 'Z' in ASCII
  MIN = -256 ** 128
  MAX = 256 ** 128
  RANGE = MIN..MAX

  def self.make_bytecode int
    unless RANGE.include? int
      raise ArgumentError, "RANGE does not include #{int}"
    end
    
    bytecode = Natural.make_bytecode(int.abs)
    bytecode[0] = CODE
    
    if int < 0
      bytecode[1] |= 0x80
    end
    
    return bytecode
  end
  
  def self.read_bytecode bytecode, offset
    if bytecode[offset] != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    offset += 1
    
    nat_size = bytecode[offset] & 0x7F
    sign = bytecode[offset] & 0x80
    offset += 1

    remaining = (bytecode.size - offset)    
    if remaining < nat_size
      raise ArgumentError, "bytecode does not contain enough information to process an INTEGER instruction"
    end
    
    natural = Natural.byte_seq_to_natural bytecode[offset, nat_size]
    offset += nat_size
    
    if sign == 0
      return natural, offset
    else
      return -natural, offset
    end
  end
end

end
end