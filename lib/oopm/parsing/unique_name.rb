class UniqueName
  
  @@unique_names = []
  
  def self.names
    return @@unique_names
  end
  
  def self.new_name
    name = rand(36**8).to_s(36)
    
    while(@@unique_names.include? name)
      name = rand(36**8).to_s(36)
    end
    
    @@unique_names << name
    
    return name
  end
end
