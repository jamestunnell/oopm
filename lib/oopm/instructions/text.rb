module OOPM
module Instructions

class Text
  CODE = 0x54 # 'T' in ASCII
  
  ENCODING_MAP = {
    Encoding::UTF_8 => 0,
    Encoding::US_ASCII => 1
  }

  ENCODING_MAP_REVERSE = {
    0 => Encoding::UTF_8,
    1 => Encoding::US_ASCII
  }
  
  def self.make_into_bytecode text
    encoding_num = ENCODING_MAP[text.encoding]
    
    if encoding_num.nil?
      raise ArgumentError, "text has encoding #{encoding}, which is not supported"
    end
    
    return [CODE] + Natural.make_into_bytecode(encoding_num) + ByteSequence.make_into_bytecode(text.bytes.to_a)
  end

  def self.make_from_bytestream bytestream
    if bytestream.read_byte != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end

    encoding_num = Natural.make_from_bytestream bytestream
    encoding = ENCODING_MAP_REVERSE[encoding_num]
    bytes = ByteSequence.make_from_bytestream bytestream
    text = bytes.pack('c*')
    text.force_encoding(encoding)
    return text
  end

end

end
end