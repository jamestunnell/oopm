module OOPM
module Instructions

class Real
  CODE = 0x52 # 'R' in ASCII
  
  def self.make_into_bytecode real
    unless real.is_a? Float
      raise ArgumentError, "#{real} is not a Float"
    end
    
    s = real.to_s
    
    pow_10 = 0
    exp_loc = s =~ /e[+-][\d]+/
    if exp_loc
      if s[exp_loc + 1] == "+"
        pow_10 += s[(exp_loc + 2)..-1].to_i
      else
        pow_10 -= s[(exp_loc + 2)..-1].to_i
      end
    end
    
    per_loc = s =~ /\./
    if per_loc
      if exp_loc
        dec_places = exp_loc - per_loc - 1
      else
        dec_places = s.size - per_loc - 1
      end
      
      frac = s[per_loc + 1, dec_places].to_i
      if frac > 0
        pow_10 -= dec_places
        num = s[0,per_loc].to_i * (10**dec_places)
        if num > 0
          num += frac
        else
          num -= frac
        end
      else
        num = s[0,per_loc].to_i
      end
    else
      if exp_loc
        num = s[0,exp_loc].to_i
      else
        num = s.to_i
      end      
    end
    
    bc = [CODE] + Integer.make_into_bytecode(num) + Integer.make_into_bytecode(pow_10)
    return bc
  end
  
  def self.make_from_bytestream bytestream
    if bytestream.read_byte != CODE
      raise ArgumentError, "bytecode does not begin with #{CODE}"
    end
    
    num = Instructions::Integer.make_from_bytestream bytestream
    pow_10 = Instructions::Integer.make_from_bytestream bytestream
    
    real = num * 10.0**pow_10
    return real
  end
end

end
end