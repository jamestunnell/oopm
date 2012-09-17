module OOPM
module Parsing

require 'treetop'

class ReferenceNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign=""
    [Assembly::Reference.new(text_value.to_sym, assign)]
  end

  include NodeType
  def node_type; NODE_TYPE_REFERENCE; end;
end

end
end