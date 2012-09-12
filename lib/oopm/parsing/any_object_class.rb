module AnyObjectNode
  def to_assembly assign_result_to = ""
    output = []
    
    if !assign_result_to.empty?
      output << "#{assign_result_to} = #{text_value}"
    end
    
    return output
  end
  
  def binary_operation?; false; end;
  def method_call?; false; end;
  def any_object?; true; end;
end
