# Autogenerated from a Treetop grammar. Edits may be lost.


module BinaryOperation
  include Treetop::Runtime

  def root
    @root ||= :binary_operation
  end

  include AnyObject

  include Whitespace

  module BinaryOperation0
    def any_object1
      elements[0]
    end

    def whitespace1
      elements[1]
    end

    def binary_operator
      elements[2]
    end

    def whitespace2
      elements[3]
    end

    def any_object2
      elements[4]
    end
  end

  def _nt_binary_operation
    start_index = index
    if node_cache[:binary_operation].has_key?(index)
      cached = node_cache[:binary_operation][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_any_object
    s0 << r1
    if r1
      r2 = _nt_whitespace
      s0 << r2
      if r2
        r3 = _nt_binary_operator
        s0 << r3
        if r3
          r4 = _nt_whitespace
          s0 << r4
          if r4
            r5 = _nt_any_object
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(BinaryOperation0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:binary_operation][start_index] = r0

    r0
  end

  def _nt_binary_operator
    start_index = index
    if node_cache[:binary_operator].has_key?(index)
      cached = node_cache[:binary_operator][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if has_terminal?("+", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("+")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if has_terminal?("-", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("-")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        if has_terminal?("*", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("*")
          r3 = nil
        end
        if r3
          r0 = r3
        else
          if has_terminal?("/", false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("/")
            r4 = nil
          end
          if r4
            r0 = r4
          else
            if has_terminal?("%", false, index)
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("%")
              r5 = nil
            end
            if r5
              r0 = r5
            else
              if has_terminal?("||", false, index)
                r6 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("||")
                r6 = nil
              end
              if r6
                r0 = r6
              else
                if has_terminal?("&&", false, index)
                  r7 = instantiate_node(SyntaxNode,input, index...(index + 2))
                  @index += 2
                else
                  terminal_parse_failure("&&")
                  r7 = nil
                end
                if r7
                  r0 = r7
                else
                  if has_terminal?("==", false, index)
                    r8 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure("==")
                    r8 = nil
                  end
                  if r8
                    r0 = r8
                  else
                    if has_terminal?("|", false, index)
                      r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("|")
                      r9 = nil
                    end
                    if r9
                      r0 = r9
                    else
                      if has_terminal?("&", false, index)
                        r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                        @index += 1
                      else
                        terminal_parse_failure("&")
                        r10 = nil
                      end
                      if r10
                        r0 = r10
                      else
                        @index = i0
                        r0 = nil
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    node_cache[:binary_operator][start_index] = r0

    r0
  end

end

class BinaryOperationParser < Treetop::Runtime::CompiledParser
  include BinaryOperation
end
