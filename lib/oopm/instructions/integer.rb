module OOPM
module Instructions

class Integer
  CODE = 0x5A # 'Z' in ASCII
  
  def self.make_bytecode int
    sign_byte = int < 0 ? 1 : 0
    return [CODE, sign_byte] + Natural.make_bytecode(int.abs)
  end
  
  def self.read_bytecode bytecode, offset
    if bytecode[offset] != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    sign_byte = bytecode[offset + 1]
    results = Instructions::Natural.read_bytecode bytecode, offset + 2
    magnitude = results[0]
    offset = results[1]
    
    if sign_byte == 0
      return magnitude, offset
    else
      return -magnitude, offset
    end
  end
end

end
end