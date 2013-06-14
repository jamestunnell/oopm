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
end

end
end