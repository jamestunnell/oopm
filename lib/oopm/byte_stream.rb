module OOPM

# to properly mixin this module, you should define methods:
#   size
#   offset
#   offset=
#   byte_at offset
#   bytes_at offset, count
module ByteStream
  def peek_byte
    return self.byte_at offset
  end

  def read_byte
    byte = self.byte_at self.offset
    self.offset += 1
    return byte
  end
  
  def peek_bytes count
    return self.bytes_at self.offset, count
  end

  def read_bytes count
    bytes = self.bytes_at self.offset, count
    self.offset += count
    return bytes
  end
  
  def reset
    self.offset = 0
  end
  
  def remaining
    self.size - self.offset
  end
end

end