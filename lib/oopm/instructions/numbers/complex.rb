module OOPM
module Instructions

class Complex
  CODE = 0x43 # 'C' in ASCII
  
  def self.make_into_bytecode complex
    unless complex.methods.include?(:real) and complex.methods.include?(:imag)
      raise ArgumentError, "#{complex} does not have :real and/or :imag methods"
    end
    
    bc = [CODE] + Numeric.make_into_bytecode(complex.real) + Numeric.make_into_bytecode(complex.imag)
    return bc
  end
  
  def self.make_from_bytestream bytestream
    if bytestream.read_byte != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    real = Instructions::Numeric.make_from_bytestream bytestream
    imag = Instructions::Numeric.make_from_bytestream bytestream
    
    return Complex(real, imag)
  end
end

end
end