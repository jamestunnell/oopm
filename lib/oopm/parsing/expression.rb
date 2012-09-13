# Autogenerated from a Treetop grammar. Edits may be lost.


module OOPM
module Parsing

module Expression
  include Treetop::Runtime

  def root
    @root ||= :expression
  end

  include AnyObject

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_binary_operation
    if r1
      r0 = r1
    else
      r2 = _nt_method_call
      if r2
        r0 = r2
      else
        r3 = _nt_grouped_expression
        if r3
          r0 = r3
        else
          r4 = _nt_any_object
          if r4
            r0 = r4
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:expression][start_index] = r0

    r0
  end

  module BinaryOperation0
    def operator
      elements[1]
    end

    def right_operand
      elements[3]
    end
  end

  module BinaryOperation1
    def left_operand
      elements[0]
    end

    def operation_chain
      elements[1]
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
    i1 = index
    r2 = _nt_method_call
    if r2
      r1 = r2
    else
      r3 = _nt_grouped_expression
      if r3
        r1 = r3
      else
        r4 = _nt_any_object
        if r4
          r1 = r4
        else
          @index = i1
          r1 = nil
        end
      end
    end
    s0 << r1
    if r1
      s5, i5 = [], index
      loop do
        i6, s6 = index, []
        s7, i7 = [], index
        loop do
          r8 = _nt_whitespace
          if r8
            s7 << r8
          else
            break
          end
        end
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        s6 << r7
        if r7
          r9 = _nt_binary_operator
          s6 << r9
          if r9
            s10, i10 = [], index
            loop do
              r11 = _nt_whitespace
              if r11
                s10 << r11
              else
                break
              end
            end
            r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
            s6 << r10
            if r10
              i12 = index
              r13 = _nt_method_call
              if r13
                r12 = r13
              else
                r14 = _nt_grouped_expression
                if r14
                  r12 = r14
                else
                  r15 = _nt_any_object
                  if r15
                    r12 = r15
                  else
                    @index = i12
                    r12 = nil
                  end
                end
              end
              s6 << r12
            end
          end
        end
        if s6.last
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          r6.extend(BinaryOperation0)
        else
          @index = i6
          r6 = nil
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      if s5.empty?
        @index = i5
        r5 = nil
      else
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
      end
      s0 << r5
    end
    if s0.last
      r0 = instantiate_node(BinaryOperationNode,input, i0...index, s0)
      r0.extend(BinaryOperation1)
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
                    if has_terminal?("=", false, index)
                      r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("=")
                      r9 = nil
                    end
                    if r9
                      r0 = r9
                    else
                      if has_terminal?("|", false, index)
                        r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                        @index += 1
                      else
                        terminal_parse_failure("|")
                        r10 = nil
                      end
                      if r10
                        r0 = r10
                      else
                        if has_terminal?("&", false, index)
                          r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
                          @index += 1
                        else
                          terminal_parse_failure("&")
                          r11 = nil
                        end
                        if r11
                          r0 = r11
                        else
                          if has_terminal?("<<", false, index)
                            r12 = instantiate_node(SyntaxNode,input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("<<")
                            r12 = nil
                          end
                          if r12
                            r0 = r12
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
      end
    end

    node_cache[:binary_operator][start_index] = r0

    r0
  end

  module MethodCall0
    def args
      elements[2]
    end

  end

  module MethodCall1
  end

  module MethodCall2
    def args
      elements[1]
    end

  end

  module MethodCall3
    def method_name
      elements[1]
    end

    def method_args
      elements[2]
    end
  end

  module MethodCall4
    def method_reciever
      elements[0]
    end

    def call_chain
      elements[1]
    end
  end

  def _nt_method_call
    start_index = index
    if node_cache[:method_call].has_key?(index)
      cached = node_cache[:method_call][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    r2 = _nt_grouped_expression
    if r2
      r1 = r2
    else
      r3 = _nt_any_object
      if r3
        r1 = r3
      else
        @index = i1
        r1 = nil
      end
    end
    s0 << r1
    if r1
      s4, i4 = [], index
      loop do
        i5, s5 = index, []
        if has_terminal?(".", false, index)
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(".")
          r6 = nil
        end
        s5 << r6
        if r6
          r7 = _nt_name
          s5 << r7
          if r7
            i8 = index
            i9, s9 = index, []
            if has_terminal?("(", false, index)
              r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("(")
              r10 = nil
            end
            s9 << r10
            if r10
              s11, i11 = [], index
              loop do
                r12 = _nt_whitespace
                if r12
                  s11 << r12
                else
                  break
                end
              end
              r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
              s9 << r11
              if r11
                r13 = _nt_args
                s9 << r13
                if r13
                  s14, i14 = [], index
                  loop do
                    r15 = _nt_whitespace
                    if r15
                      s14 << r15
                    else
                      break
                    end
                  end
                  r14 = instantiate_node(SyntaxNode,input, i14...index, s14)
                  s9 << r14
                  if r14
                    if has_terminal?(")", false, index)
                      r16 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure(")")
                      r16 = nil
                    end
                    s9 << r16
                  end
                end
              end
            end
            if s9.last
              r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
              r9.extend(MethodCall0)
            else
              @index = i9
              r9 = nil
            end
            if r9
              r8 = r9
            else
              i17, s17 = index, []
              if has_terminal?("(", false, index)
                r18 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("(")
                r18 = nil
              end
              s17 << r18
              if r18
                s19, i19 = [], index
                loop do
                  r20 = _nt_whitespace
                  if r20
                    s19 << r20
                  else
                    break
                  end
                end
                r19 = instantiate_node(SyntaxNode,input, i19...index, s19)
                s17 << r19
                if r19
                  if has_terminal?(")", false, index)
                    r21 = instantiate_node(SyntaxNode,input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure(")")
                    r21 = nil
                  end
                  s17 << r21
                end
              end
              if s17.last
                r17 = instantiate_node(SyntaxNode,input, i17...index, s17)
                r17.extend(MethodCall1)
              else
                @index = i17
                r17 = nil
              end
              if r17
                r8 = r17
              else
                i22, s22 = index, []
                s23, i23 = [], index
                loop do
                  r24 = _nt_whitespace
                  if r24
                    s23 << r24
                  else
                    break
                  end
                end
                r23 = instantiate_node(SyntaxNode,input, i23...index, s23)
                s22 << r23
                if r23
                  r25 = _nt_args
                  s22 << r25
                  if r25
                    s26, i26 = [], index
                    loop do
                      r27 = _nt_whitespace
                      if r27
                        s26 << r27
                      else
                        break
                      end
                    end
                    r26 = instantiate_node(SyntaxNode,input, i26...index, s26)
                    s22 << r26
                  end
                end
                if s22.last
                  r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
                  r22.extend(MethodCall2)
                else
                  @index = i22
                  r22 = nil
                end
                if r22
                  r8 = r22
                else
                  if has_terminal?("", false, index)
                    r28 = instantiate_node(SyntaxNode,input, index...(index + 0))
                    @index += 0
                  else
                    terminal_parse_failure("")
                    r28 = nil
                  end
                  if r28
                    r8 = r28
                  else
                    @index = i8
                    r8 = nil
                  end
                end
              end
            end
            s5 << r8
          end
        end
        if s5.last
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          r5.extend(MethodCall3)
        else
          @index = i5
          r5 = nil
        end
        if r5
          s4 << r5
        else
          break
        end
      end
      if s4.empty?
        @index = i4
        r4 = nil
      else
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
      end
      s0 << r4
    end
    if s0.last
      r0 = instantiate_node(MethodCallNode,input, i0...index, s0)
      r0.extend(MethodCall4)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:method_call][start_index] = r0

    r0
  end

  module Args0
    def another_arg
      elements[2]
    end

  end

  module Args1
    def first_arg
      elements[0]
    end

    def more_args
      elements[2]
    end
  end

  def _nt_args
    start_index = index
    if node_cache[:args].has_key?(index)
      cached = node_cache[:args][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_expression
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        r3 = _nt_whitespace
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        s4, i4 = [], index
        loop do
          i5, s5 = index, []
          if has_terminal?(",", false, index)
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(",")
            r6 = nil
          end
          s5 << r6
          if r6
            s7, i7 = [], index
            loop do
              r8 = _nt_whitespace
              if r8
                s7 << r8
              else
                break
              end
            end
            r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
            s5 << r7
            if r7
              r9 = _nt_expression
              s5 << r9
              if r9
                s10, i10 = [], index
                loop do
                  r11 = _nt_whitespace
                  if r11
                    s10 << r11
                  else
                    break
                  end
                end
                r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
                s5 << r10
              end
            end
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(Args0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        s0 << r4
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Args1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:args][start_index] = r0

    r0
  end

  module GroupedExpression0
    def expression
      elements[2]
    end

  end

  def _nt_grouped_expression
    start_index = index
    if node_cache[:grouped_expression].has_key?(index)
      cached = node_cache[:grouped_expression][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("(", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        r3 = _nt_whitespace
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        r4 = _nt_expression
        s0 << r4
        if r4
          s5, i5 = [], index
          loop do
            r6 = _nt_whitespace
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s0 << r5
          if r5
            if has_terminal?(")", false, index)
              r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r7 = nil
            end
            s0 << r7
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(GroupedExpressionNode,input, i0...index, s0)
      r0.extend(GroupedExpression0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:grouped_expression][start_index] = r0

    r0
  end

  def _nt_whitespace
    start_index = index
    if node_cache[:whitespace].has_key?(index)
      cached = node_cache[:whitespace][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if has_terminal?('\G[\\s]', true, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r0 = nil
    end

    node_cache[:whitespace][start_index] = r0

    r0
  end

end

class ExpressionParser < Treetop::Runtime::CompiledParser
  include Expression
end


end
end