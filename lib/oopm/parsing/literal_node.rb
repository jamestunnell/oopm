module OOPM
module Parsing

module LiteralNode
  def to_assembly assign=""
    [Assembly::Literal.new(eval(text_value), assign)]
  end  
  
  include NodeType
  def node_type; NODE_TYPE_LITERAL; end;
end

end
end
