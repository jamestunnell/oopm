module OOPM
module Instructions

class ByteSequence
  CODE = 0x42 # 'B' in ASCII
  
  def self.make_bytecode bytes
    oob = bytes.select {|b| b > 0xFF }
    if oob.any?
      raise ArgumentError, "bytes contains #{oob.count} numbers that are greater than 0xFF"
    end
    
    size_bytecode = Natural.make_bytecode bytes.size
    return [CODE] + size_bytecode + bytes
  end
  
  def self.read_bytecode bytecode, offset
    if bytecode[offset] != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    results = Instructions::Natural.read_bytecode bytecode, offset + 1
    size = results[0]
    offset = results[1]
    
    byte_sequence = bytecode[offset, size]
    return byte_sequence, offset + size
  end
end

end
end