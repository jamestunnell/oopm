module OOPM
module Instructions

class ByteSequence
  CODE = 0x42 # 'B' in ASCII
  
  def self.make_into_bytecode bytes
    oob = bytes.select {|b| b > 0xFF }
    if oob.any?
      raise ArgumentError, "bytes contains #{oob.count} numbers that are greater than 0xFF"
    end
    
    size_bytecode = Natural.make_into_bytecode bytes.size
    return [CODE] + size_bytecode + bytes
  end
  
  def self.make_from_bytestream bytestream
    if bytestream.read_byte != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    size = Instructions::Natural.make_from_bytestream bytestream
    byte_sequence = bytestream.read_bytes size
    return byte_sequence
  end
end

end
end