module OOPM
module Instructions

class Rational
  CODE = 0x51 # 'Q' in ASCII
  
  def self.make_into_bytecode rational
    unless rational.methods.include?(:numerator) and rational.methods.include?(:denominator)
      raise ArgumentError, "#{rational} does not have :numerator and/or :denominator methods"
    end
    
    bc = [CODE] + Integer.make_into_bytecode(rational.numerator) + Integer.make_into_bytecode(rational.denominator)
    return bc
  end
  
  def self.make_from_bytestream bytestream
    if bytestream.read_byte != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    numerator = Instructions::Integer.make_from_bytestream bytestream
    denominator = Instructions::Integer.make_from_bytestream bytestream
    
    return Rational(numerator, denominator)
  end
end

end
end