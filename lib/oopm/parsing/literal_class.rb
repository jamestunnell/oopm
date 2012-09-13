module OOPM
module Parsing

module LiteralNode
  def to_assembly assign_result_to=""
    return [Assembly::Literal.new(text_value, assign_result_to)]
  end
  
  def binary_operation?; false; end;
  def method_call?; false; end;
  def literal?; true; end;
end

end
end
