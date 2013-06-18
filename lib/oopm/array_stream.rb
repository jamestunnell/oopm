module OOPM
  
class ArrayStream
  include ByteStream
  attr_accessor :offset
  
  def initialize ary
    @ary = ary
    @offset = 0
  end
  
  def size
    return @ary.size
  end
    
  def byte_at offset
    return @ary[offset]
  end

  def bytes_at offset, count
    return @ary[offset, count]
  end
end

end