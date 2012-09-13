module OOPM
module Util

class UniqueName  
  def self.new_name
    rand(36**8).to_s(36)
  end
end

end
end