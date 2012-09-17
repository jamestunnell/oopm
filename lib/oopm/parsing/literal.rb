# Autogenerated from a Treetop grammar. Edits may be lost.


module OOPM
module Parsing

module Literal
  include Treetop::Runtime

  def root
    @root ||= :literal
  end

  def _nt_literal
    start_index = index
    if node_cache[:literal].has_key?(index)
      cached = node_cache[:literal][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_symbol
    if r1
      r0 = r1
      r0.extend(LiteralNode)
    else
      r2 = _nt_string
      if r2
        r0 = r2
        r0.extend(LiteralNode)
      else
        r3 = _nt_number
        if r3
          r0 = r3
          r0.extend(LiteralNode)
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:literal][start_index] = r0

    r0
  end

  module Symbol0
  end

  module Symbol1
  end

  def _nt_symbol
    start_index = index
    if node_cache[:symbol].has_key?(index)
      cached = node_cache[:symbol][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?(":", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(":")
      r1 = nil
    end
    s0 << r1
    if r1
      i2 = index
      r3 = _nt_string
      if r3
        r2 = r3
      else
        i4, s4 = index, []
        if has_terminal?('\G[_a-zA-Z]', true, index)
          r5 = true
          @index += 1
        else
          r5 = nil
        end
        s4 << r5
        if r5
          s6, i6 = [], index
          loop do
            if has_terminal?('\G[_a-zA-Z0-9]', true, index)
              r7 = true
              @index += 1
            else
              r7 = nil
            end
            if r7
              s6 << r7
            else
              break
            end
          end
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          s4 << r6
        end
        if s4.last
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          r4.extend(Symbol0)
        else
          @index = i4
          r4 = nil
        end
        if r4
          r2 = r4
        else
          @index = i2
          r2 = nil
        end
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Symbol1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:symbol][start_index] = r0

    r0
  end

  def _nt_string
    start_index = index
    if node_cache[:string].has_key?(index)
      cached = node_cache[:string][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_double_quoted
    if r1
      r0 = r1
    else
      r2 = _nt_single_quoted
      if r2
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:string][start_index] = r0

    r0
  end

  module SingleQuoted0
  end

  module SingleQuoted1
  end

  def _nt_single_quoted
    start_index = index
    if node_cache[:single_quoted].has_key?(index)
      cached = node_cache[:single_quoted][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\'', false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('\'')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        if has_terminal?('\\\'', false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure('\\\'')
          r4 = nil
        end
        if r4
          r3 = r4
        else
          i5, s5 = index, []
          i6 = index
          if has_terminal?('\'', false, index)
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('\'')
            r7 = nil
          end
          if r7
            r6 = nil
          else
            @index = i6
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            if index < input_length
              r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("any character")
              r8 = nil
            end
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(SingleQuoted0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            r3 = r5
          else
            @index = i3
            r3 = nil
          end
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
        if has_terminal?('\'', false, index)
          r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('\'')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(SingleQuoted1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:single_quoted][start_index] = r0

    r0
  end

  module DoubleQuoted0
  end

  module DoubleQuoted1
  end

  def _nt_double_quoted
    start_index = index
    if node_cache[:double_quoted].has_key?(index)
      cached = node_cache[:double_quoted][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('"', false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        if has_terminal?('\"', false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure('\"')
          r4 = nil
        end
        if r4
          r3 = r4
        else
          i5, s5 = index, []
          i6 = index
          if has_terminal?('"', false, index)
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('"')
            r7 = nil
          end
          if r7
            r6 = nil
          else
            @index = i6
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            if index < input_length
              r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("any character")
              r8 = nil
            end
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(DoubleQuoted0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            r3 = r5
          else
            @index = i3
            r3 = nil
          end
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
        if has_terminal?('"', false, index)
          r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(DoubleQuoted1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:double_quoted][start_index] = r0

    r0
  end

  module Number0
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    s2, i2 = [], index
    loop do
      if has_terminal?('\G[\\d]', true, index)
        r3 = true
        @index += 1
      else
        r3 = nil
      end
      if r3
        s2 << r3
      else
        break
      end
    end
    r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
    s1 << r2
    if r2
      if has_terminal?(".", false, index)
        r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(".")
        r5 = nil
      end
      if r5
        r4 = r5
      else
        r4 = instantiate_node(SyntaxNode,input, index...index)
      end
      s1 << r4
      if r4
        s6, i6 = [], index
        loop do
          if has_terminal?('\G[\\d]', true, index)
            r7 = true
            @index += 1
          else
            r7 = nil
          end
          if r7
            s6 << r7
          else
            break
          end
        end
        if s6.empty?
          @index = i6
          r6 = nil
        else
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
        end
        s1 << r6
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Number0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      s8, i8 = [], index
      loop do
        if has_terminal?('\G[\\d]', true, index)
          r9 = true
          @index += 1
        else
          r9 = nil
        end
        if r9
          s8 << r9
        else
          break
        end
      end
      if s8.empty?
        @index = i8
        r8 = nil
      else
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
      end
      if r8
        r0 = r8
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:number][start_index] = r0

    r0
  end

end

class LiteralParser < Treetop::Runtime::CompiledParser
  include Literal
end


end
end