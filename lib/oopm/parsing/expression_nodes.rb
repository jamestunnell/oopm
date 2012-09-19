module OOPM
module Parsing

require 'treetop'

class AssignmentNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign_to=:""
    
    assembly_statements = expression.to_assembly(reference.text_value.to_sym)
    
    if !assign_to.empty?
      assembly_statements << Assembly::Reference.new(assembly_statements.last.statement_id, assign_to)
    end
    
    return assembly_statements
  end

  include NodeType
  def node_type; NODE_TYPE_ASSIGNMENT; end;
end

class BinaryOperationNode < Treetop::Runtime::SyntaxNode

  def to_assembly assign_to=:""

    assembly_statements = []
    
    reciever = nil
    if left_operand.reference?
      reciever = left_operand.text_value.to_sym
    elsif left_operand.literal?
      reciever = eval(left_operand.text_value)
    else
      assembly_statements += left_operand.to_assembly
      reciever = assembly_statements.last.statement_id
    end
    
    for i in 0...operation_chain.elements.length

      method = operation_chain.elements[i].operator.text_value.to_sym

      right_operand = operation_chain.elements[i].right_operand
      arg = nil
      
      if right_operand.reference?
        arg = right_operand.text_value.to_sym
      elsif right_operand.literal?
        arg = eval(right_operand.text_value)
      else
        assembly_statements += right_operand.to_assembly
        arg = assembly_statements.last.statement_id
      end

      assign = (i == (operation_chain.elements.length - 1)) ? assign_to : :""

      assembly_statements << Assembly::SendMsg.new(reciever, method, [arg], assign)
      
      reciever = assembly_statements.last.statement_id

    end

    return assembly_statements
  end

  include NodeType
  def node_type; NODE_TYPE_BINARY_OPERATION; end;
end

class MethodCallNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign_to= :""

    assembly_statements = []
    reciever = nil
    
    if method_reciever.reference?
      reciever = method_reciever.text_value.to_sym
    elsif method_reciever.literal?
      reciever = eval(method_reciever.text_value)
    else
      assembly_statements += method_reciever.to_assembly
      reciever = assembly_statements.last.statement_id
    end

    for i in 0...call_chain.elements.length

      method = (call_chain.elements[i].prefix.text_value + call_chain.elements[i].suffix.text_value).to_sym
      assign = (i == (call_chain.elements.length - 1)) ? assign_to : :""

      arg_nodes = []
      if call_chain.elements[i].respond_to? :method_args
        method_args = call_chain.elements[i].method_args
        arg_nodes << method_args.first_arg
        
        if method_args.respond_to? :more_args
          method_args.more_args.elements.each do |element|
            arg_nodes << element.another_arg
          end
        end
      end

      args = []
      arg_nodes.each do |arg_node|
        if arg_node.reference?
          args << arg_node.text_value.to_sym
        elsif arg_node.literal?
          args << eval(arg_node.text_value)
        else
          assembly_statements += arg_node.to_assembly
          args << assembly_statements.last.statement_id
        end
      end

      assembly_statements << Assembly::SendMsg.new(reciever, method, args, assign)
      reciever = assembly_statements.last.statement_id
    end

    return assembly_statements
  end

  include NodeType
  def node_type; NODE_TYPE_METHOD_CALL; end;
end

class GroupedExpressionNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign_to=:""
    return expression.to_assembly assign_to
  end

  include NodeType
  def node_type; expression.node_type; end;
end

end
end
