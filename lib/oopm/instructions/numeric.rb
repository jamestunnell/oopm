module OOPM
module Instructions

class Numeric
  def self.make_into_bytecode numeric
    if numeric.is_a? Fixnum or numeric.is_a? Bignum
      return Integer.make_into_bytecode numeric  
    elsif numeric.is_a? Float
      return Real.make_into_bytecode numeric
    else
      raise ArgumentError, "#{numeric} is not a Fixnum, Bignum, or Float."
    end
  end

  def self.make_from_bytestream bytestream
    case bytestream.peek_byte
    when Integer::CODE
      return Integer.make_from_bytestream bytestream
    when Real::CODE
      return Real.make_from_bytestream bytestream
    else
      raise ArgumentError, "unsupported Numeric code #{bytestream.peek_byte}"
    end
  end
end

end
end