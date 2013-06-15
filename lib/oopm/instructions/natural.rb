module OOPM
module Instructions

class Natural
  CODE = 0x4E # 'N' in ASCII
  
  def self.make_bytecode natural
    if natural == 0
      return [CODE, 1, 0]
    elsif natural < 0
      raise ArgumentError, "natural #{natural} is less than 0"
    end
    
    bytes = []
    
    while natural > 0
      bytes.push natural & 0xFF
      natural >>= 8
    end
    
    return [CODE, bytes.size] + bytes.reverse
  end
  
  def self.read_bytecode bytecode, offset
    if bytecode[offset] != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    nat_size = bytecode[offset + 1]
    remaining = (bytecode.size - offset + 1)
    
    if remaining < nat_size
      raise ArgumentError, "bytecode does not contain enough information to process a NATURAL instruction"
    end
    
    result = 0
    nat_size.times do |n|
      byte = bytecode[offset + 2 + n]
      result += byte * 256**(nat_size - 1 - n)
    end
    
    return result, offset + 2 + nat_size
  end
end

end
end