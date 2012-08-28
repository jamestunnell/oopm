# Autogenerated from a Treetop grammar. Edits may be lost.


module BinaryOperation
  include Treetop::Runtime

  def root
    @root ||= :binary_operation
  end

  include Number

  module BinaryOperation0
    def number1
      elements[0]
    end

    def number2
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
    r1 = _nt_number
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?(" ", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(" ")
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        i4 = index
        if has_terminal?("+", false, index)
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("+")
          r5 = nil
        end
        if r5
          r4 = r5
        else
          if has_terminal?("-", false, index)
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("-")
            r6 = nil
          end
          if r6
            r4 = r6
          else
            if has_terminal?("*", false, index)
              r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("*")
              r7 = nil
            end
            if r7
              r4 = r7
            else
              if has_terminal?("/", false, index)
                r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("/")
                r8 = nil
              end
              if r8
                r4 = r8
              else
                if has_terminal?("%", false, index)
                  r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("%")
                  r9 = nil
                end
                if r9
                  r4 = r9
                else
                  if has_terminal?("||", false, index)
                    r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure("||")
                    r10 = nil
                  end
                  if r10
                    r4 = r10
                  else
                    if has_terminal?("&&", false, index)
                      r11 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("&&")
                      r11 = nil
                    end
                    if r11
                      r4 = r11
                    else
                      if has_terminal?("==", false, index)
                        r12 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("==")
                        r12 = nil
                      end
                      if r12
                        r4 = r12
                      else
                        if has_terminal?("|", false, index)
                          r13 = instantiate_node(SyntaxNode,input, index...(index + 1))
                          @index += 1
                        else
                          terminal_parse_failure("|")
                          r13 = nil
                        end
                        if r13
                          r4 = r13
                        else
                          if has_terminal?("&", false, index)
                            r14 = instantiate_node(SyntaxNode,input, index...(index + 1))
                            @index += 1
                          else
                            terminal_parse_failure("&")
                            r14 = nil
                          end
                          if r14
                            r4 = r14
                          else
                            @index = i4
                            r4 = nil
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
        s0 << r4
        if r4
          s15, i15 = [], index
          loop do
            if has_terminal?(" ", false, index)
              r16 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(" ")
              r16 = nil
            end
            if r16
              s15 << r16
            else
              break
            end
          end
          r15 = instantiate_node(SyntaxNode,input, i15...index, s15)
          s0 << r15
          if r15
            r17 = _nt_number
            s0 << r17
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

end

class BinaryOperationParser < Treetop::Runtime::CompiledParser
  include BinaryOperation
end
