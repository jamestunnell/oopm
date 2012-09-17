module OOPM
module Parsing

module NodeType
  NODE_TYPE_REFERENCE = :NodeTypeReference
  NODE_TYPE_LITERAL = :NodeTypeLiteral
  NODE_TYPE_ASSIGNMENT = :NodeTypeAssignment
  NODE_TYPE_BINARY_OPERATION = :NodeTypeBinaryOperation
  NODE_TYPE_METHOD_CALL = :NodeTypeMethodCall
  NODE_TYPE_GROUPED_EXPRESSION = :NodeTypeGroupedExpression
  
  def reference?
    return node_type == NODE_TYPE_REFERENCE
  end

  def literal?
    return node_type == NODE_TYPE_LITERAL
  end
  
  def assignment?
    return node_type == NODE_TYPE_ASSIGNMENT
  end
  
  def binary_operation?
    return node_type == NODE_TYPE_BINARY_OPERATION
  end
  
  def method_call?
    return node_type == NODE_TYPE_METHOD_CALL
  end
  
  def grouped_expression?
    return node_type == NODE_TYPE_GROUPED_EXPRESSION
  end  
end

end
end