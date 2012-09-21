# Autogenerated from a Treetop grammar. Edits may be lost.


module OOPM
module Parsing

module Container
  include Treetop::Runtime

  def root
    @root ||= :container
  end

  module Container0
    include NodeType
    def node_type; NODE_TYPE_CONTAINER; end;
  end

  def _nt_container
    start_index = index
    if node_cache[:container].has_key?(index)
      cached = node_cache[:container][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_array
    if r1
      r0 = r1
      r0.extend(Container0)
    else
      r2 = _nt_hash
      if r2
        r0 = r2
        r0.extend(Container0)
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:container][start_index] = r0

    r0
  end

  module Hash0
    def key
      elements[1]
    end

    def value
      elements[5]
    end
  end

  module Hash1
    def key
      elements[3]
    end

    def value
      elements[7]
    end
  end

  module Hash2
    def first_entry
      elements[0]
    end

    def more_entries
      elements[1]
    end

  end

  module Hash3
    def entries
      elements[1]
    end

  end

  def _nt_hash
    start_index = index
    if node_cache[:hash].has_key?(index)
      cached = node_cache[:hash][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("{", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("{")
      r1 = nil
    end
    s0 << r1
    if r1
      i2 = index
      i3, s3 = index, []
      i4, s4 = index, []
      s5, i5 = [], index
      loop do
        r6 = _nt_ws
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
      s4 << r5
      if r5
        r7 = _nt_expression
        s4 << r7
        if r7
          s8, i8 = [], index
          loop do
            r9 = _nt_ws
            if r9
              s8 << r9
            else
              break
            end
          end
          r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
          s4 << r8
          if r8
            if has_terminal?("=>", false, index)
              r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure("=>")
              r10 = nil
            end
            s4 << r10
            if r10
              s11, i11 = [], index
              loop do
                r12 = _nt_ws
                if r12
                  s11 << r12
                else
                  break
                end
              end
              r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
              s4 << r11
              if r11
                r13 = _nt_expression
                s4 << r13
              end
            end
          end
        end
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(Hash0)
      else
        @index = i4
        r4 = nil
      end
      s3 << r4
      if r4
        s14, i14 = [], index
        loop do
          i15, s15 = index, []
          s16, i16 = [], index
          loop do
            r17 = _nt_ws
            if r17
              s16 << r17
            else
              break
            end
          end
          r16 = instantiate_node(SyntaxNode,input, i16...index, s16)
          s15 << r16
          if r16
            if has_terminal?(",", false, index)
              r18 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(",")
              r18 = nil
            end
            s15 << r18
            if r18
              s19, i19 = [], index
              loop do
                r20 = _nt_ws
                if r20
                  s19 << r20
                else
                  break
                end
              end
              r19 = instantiate_node(SyntaxNode,input, i19...index, s19)
              s15 << r19
              if r19
                r21 = _nt_expression
                s15 << r21
                if r21
                  s22, i22 = [], index
                  loop do
                    r23 = _nt_ws
                    if r23
                      s22 << r23
                    else
                      break
                    end
                  end
                  r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
                  s15 << r22
                  if r22
                    if has_terminal?("=>", false, index)
                      r24 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("=>")
                      r24 = nil
                    end
                    s15 << r24
                    if r24
                      s25, i25 = [], index
                      loop do
                        r26 = _nt_ws
                        if r26
                          s25 << r26
                        else
                          break
                        end
                      end
                      r25 = instantiate_node(SyntaxNode,input, i25...index, s25)
                      s15 << r25
                      if r25
                        r27 = _nt_expression
                        s15 << r27
                      end
                    end
                  end
                end
              end
            end
          end
          if s15.last
            r15 = instantiate_node(SyntaxNode,input, i15...index, s15)
            r15.extend(Hash1)
          else
            @index = i15
            r15 = nil
          end
          if r15
            s14 << r15
          else
            break
          end
        end
        r14 = instantiate_node(SyntaxNode,input, i14...index, s14)
        s3 << r14
        if r14
          s28, i28 = [], index
          loop do
            r29 = _nt_ws
            if r29
              s28 << r29
            else
              break
            end
          end
          r28 = instantiate_node(SyntaxNode,input, i28...index, s28)
          s3 << r28
          if r28
            if has_terminal?(",", false, index)
              r31 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(",")
              r31 = nil
            end
            if r31
              r30 = r31
            else
              r30 = instantiate_node(SyntaxNode,input, index...index)
            end
            s3 << r30
            if r30
              s32, i32 = [], index
              loop do
                r33 = _nt_ws
                if r33
                  s32 << r33
                else
                  break
                end
              end
              r32 = instantiate_node(SyntaxNode,input, i32...index, s32)
              s3 << r32
            end
          end
        end
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(Hash2)
      else
        @index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        s34, i34 = [], index
        loop do
          r35 = _nt_ws
          if r35
            s34 << r35
          else
            break
          end
        end
        r34 = instantiate_node(SyntaxNode,input, i34...index, s34)
        if r34
          r2 = r34
        else
          @index = i2
          r2 = nil
        end
      end
      s0 << r2
      if r2
        if has_terminal?("}", false, index)
          r36 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("}")
          r36 = nil
        end
        s0 << r36
      end
    end
    if s0.last
      r0 = instantiate_node(HashNode,input, i0...index, s0)
      r0.extend(Hash3)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:hash][start_index] = r0

    r0
  end

  module Array0
    def value
      elements[1]
    end
  end

  module Array1
    def value
      elements[3]
    end
  end

  module Array2
    def first_entry
      elements[0]
    end

    def more_entries
      elements[1]
    end

  end

  module Array3
    def entries
      elements[1]
    end

  end

  def _nt_array
    start_index = index
    if node_cache[:array].has_key?(index)
      cached = node_cache[:array][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("[", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("[")
      r1 = nil
    end
    s0 << r1
    if r1
      i2 = index
      i3, s3 = index, []
      i4, s4 = index, []
      s5, i5 = [], index
      loop do
        r6 = _nt_ws
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
      s4 << r5
      if r5
        r7 = _nt_expression
        s4 << r7
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(Array0)
      else
        @index = i4
        r4 = nil
      end
      s3 << r4
      if r4
        s8, i8 = [], index
        loop do
          i9, s9 = index, []
          s10, i10 = [], index
          loop do
            r11 = _nt_ws
            if r11
              s10 << r11
            else
              break
            end
          end
          r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
          s9 << r10
          if r10
            if has_terminal?(",", false, index)
              r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(",")
              r12 = nil
            end
            s9 << r12
            if r12
              s13, i13 = [], index
              loop do
                r14 = _nt_ws
                if r14
                  s13 << r14
                else
                  break
                end
              end
              r13 = instantiate_node(SyntaxNode,input, i13...index, s13)
              s9 << r13
              if r13
                r15 = _nt_expression
                s9 << r15
              end
            end
          end
          if s9.last
            r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
            r9.extend(Array1)
          else
            @index = i9
            r9 = nil
          end
          if r9
            s8 << r9
          else
            break
          end
        end
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
        s3 << r8
        if r8
          s16, i16 = [], index
          loop do
            r17 = _nt_ws
            if r17
              s16 << r17
            else
              break
            end
          end
          r16 = instantiate_node(SyntaxNode,input, i16...index, s16)
          s3 << r16
          if r16
            if has_terminal?(",", false, index)
              r19 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(",")
              r19 = nil
            end
            if r19
              r18 = r19
            else
              r18 = instantiate_node(SyntaxNode,input, index...index)
            end
            s3 << r18
            if r18
              s20, i20 = [], index
              loop do
                r21 = _nt_ws
                if r21
                  s20 << r21
                else
                  break
                end
              end
              r20 = instantiate_node(SyntaxNode,input, i20...index, s20)
              s3 << r20
            end
          end
        end
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(Array2)
      else
        @index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        s22, i22 = [], index
        loop do
          r23 = _nt_ws
          if r23
            s22 << r23
          else
            break
          end
        end
        r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
        if r22
          r2 = r22
        else
          @index = i2
          r2 = nil
        end
      end
      s0 << r2
      if r2
        if has_terminal?("]", false, index)
          r24 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("]")
          r24 = nil
        end
        s0 << r24
      end
    end
    if s0.last
      r0 = instantiate_node(ArrayNode,input, i0...index, s0)
      r0.extend(Array3)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:array][start_index] = r0

    r0
  end

end

class ContainerParser < Treetop::Runtime::CompiledParser
  include Container
end


end
end