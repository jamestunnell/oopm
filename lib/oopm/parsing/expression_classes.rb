require 'treetop'

class BinaryOperationNode < Treetop::Runtime::SyntaxNode
  
  def to_assembly assign_result_to = ""
  
    assembly_statements = []
    reciever = left_operand.text_value
    
    if !left_operand.any_object?
      reciever = UniqueName.new_name
      assembly_statements << left_operand.to_assembly(reciever)
    end
    
    for i in 0...operation_chain.elements.length
      
      method = operation_chain.elements[i].operator.text_value
      right_operand = operation_chain.elements[i].right_operand
      
      assign = (i == (operation_chain.elements.length - 1)) ? assign_result_to : UniqueName.new_name
      
      if right_operand.any_object?
        assembly_statements << Assembly::SendMsg.new(assign, reciever, method, [right_operand.text_value])
      else
        name = UniqueName.new_name
        assembly_statements << right_operand.to_assembly(name)
        assembly_statements << Assembly::SendMsg.new(assign, reciever, method, [name])
      end
      
      reciever = assign
    end
    
    return assembly_statements
  end
  
  def binary_operation?; true; end;
  def method_call?; false; end;
  def any_object?; false; end;
end

class MethodCallNode < Treetop::Runtime::SyntaxNode
  def to_assembly assign_result_to = ""
    assembly_statements = []
    reciever = method_reciever.text_value
    
    if !method_reciever.any_object?
      reciever = UniqueName.new_name
      assembly_statements << method_reciever.to_assembly(reciever)
    end
    
    for i in 0...call_chain.elements.length
      
      method = call_chain.elements[i].method_name.text_value
      assign = (i == (call_chain.elements.length - 1)) ? assign_result_to : UniqueName.new_name

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
        if !arg.any_object?
          arg_string << UniqueName.new_name
          assembly_statements << arg.to_assembly(arg_string)
          arg_strings << arg_string
        else
          arg_strings << arg.text_value
        end
      end
      
      assembly_statements << Assembly::SendMsg.new(assign, reciever, method, arg_strings)
      
      reciever = assign
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
