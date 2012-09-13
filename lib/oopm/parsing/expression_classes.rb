module OOPM
module Parsing

require 'treetop'

class BinaryOperationNode < Treetop::Runtime::SyntaxNode
  
  def to_assembly assign_result_to=""
  
    assembly_statements = left_operand.to_assembly
    
    for i in 0...operation_chain.elements.length
      
      reciever = assembly_statements.last.statement_id
      method = operation_chain.elements[i].operator.text_value
      right_operand = operation_chain.elements[i].right_operand
      
      assign = (i == (operation_chain.elements.length - 1)) ? assign_result_to : ""
      
      assembly_statements += right_operand.to_assembly
      assembly_statements << Assembly::SendMsg.new(reciever, method, [assembly_statements.last.statement_id], assign)
      
    end
    
    return assembly_statements
  end
  
  def binary_operation?; true; end;
  def method_call?; false; end;
  def any_object?; false; end;
end

class MethodCallNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign_result_to = ""
    raise NotImplementedError
    
    assembly_statements = method_reciever.to_assembly
    
    for i in 0...call_chain.elements.length
      
      reciever = assembly_statements.last.statement_id
      method = call_chain.elements[i].method_name.text_value
      assign = (i == (call_chain.elements.length - 1)) ? assign_result_to : ""
    
      method_args = call_chain.elements[i].method_args
      arg_nodes = []
      if method_args.respond_to? :args
        arg_nodes << method_args.args.first_arg
        
        if method_args.args.respond_to? :more_args
          method_args.args.more_args.elements.each do |element|
            arg_nodes << element.another_arg
          end
        end
      end
      
      arg_strings = []
      arg_nodes.each do |arg|
        assembly_statements += arg.to_assembly
        arg_strings << assembly_statements.last.statement_id
      end
      
      assembly_statements << Assembly::SendMsg.new(reciever, method, arg_strings, assign)
    end
    
    return assembly_statements
  end

  def binary_operation?; false; end;
  def method_call?; true; end;
  def any_object?; false; end;      
end

class GroupedExpressionNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign_result_to = ""
    return expression.to_assembly assign_result_to
  end

  def binary_operation?
    return expression.binary_operation?
  end
  
  def method_call?
    return expression.method_call?
  end
  
  def any_object?
    return expression.any_object?
  end
end

end
end