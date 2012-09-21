module OOPM
module Parsing

require 'treetop'

class HashNode < Treetop::Runtime::SyntaxNode
  def add_entry hash, key_node, value_node
    new_statements = []
    key = nil
    
    if key_node.reference?
      key = key_node.text_value.to_sym
    elsif key_node.literal?
      key = eval(key_node.text_value)
    else
      new_statements += key_node.to_assembly
      key = new_statements.last.statement_id
    end

    if value_node.reference?
      hash[key] = value_node.text_value.to_sym
    elsif value_node.literal?
      hash[key] = eval(value_node.text_value)
    else
      new_statements += value_node.to_assembly
      hash[key] = new_statements.last.statement_id        
    end
    
    return new_statements
  end
  
  def to_assembly assign_to = :""
    statements = []
    hash = {}
    
    if entries.respond_to? :first_entry
      statements += add_entry(hash, entries.first_entry.key, entries.first_entry.value)
    end
    
    if entries.respond_to? :more_entries
      entries.more_entries.elements.each do |element|
        statements += add_entry(hash, element.key, element.value)
      end
    end

    statements << Assembly::Literal.new(hash, assign_to)
    return statements
  end
end

class ArrayNode < Treetop::Runtime::SyntaxNode
  def add_entry array, value_node
    new_statements = []
    if value_node.reference?
      array << value_node.text_value.to_sym
    elsif value_node.literal?
      array << eval(value_node.text_value)
    else
      new_statements += value_node.to_assembly
      array << new_statements.last.statement_id
    end
    
    return new_statements
  end
  
  def to_assembly assign_to = :""
    statements = []
    array = []
    
    if entries.respond_to? :first_entry
      statements += add_entry(array, entries.first_entry.value)
    end
    
    if entries.respond_to? :more_entries
      entries.more_entries.elements.each do |element|
        statements += add_entry(array, element.value)
      end
    end
    
    statements << Assembly::Literal.new(array, assign_to)
    
    return statements
  end
end

end
end