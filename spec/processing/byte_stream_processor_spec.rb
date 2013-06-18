require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'pry'
describe OOPM::Processing::ByteStreamProcessor do
  describe '#process_bytes' do
    context 'bytecode for natural numbers' do
      before :all do
        @single_naturals = [
          0x1,
          0x123,
          0x12345,
          0x1234567,
          0x123456789,
          0x123456789AB,
          0x123456789ABCD,
          0x123456789ABCDEF,
        ]
        
        @multiple_naturals = [
          [0x11, 0x22, 0x3456789],
          [0x9876543210, 0x791098471057183047, 0x734, 0x28138, 0x991]
        ]
      end
      
      it 'should correctly process bytecode for a single natural number' do
        @single_naturals.each do |natural|
          bytes = Instructions::Natural.make_into_bytecode natural
          bytestream = ArrayStream.new bytes
          bp = OOPM::Processing::ByteStreamProcessor.new bytestream
          bp.process_next.should eq natural
        end
      end

      it 'should correctly process bytecode for multiple natural numbers' do
        @multiple_naturals.each do |naturals|
          bytes = []
          naturals.each do |natural|
            bytes += Instructions::Natural.make_into_bytecode natural
          end
          
          bp = OOPM::Processing::ByteStreamProcessor.new ArrayStream.new(bytes)
          naturals.count.times do
            bp.process_next
          end
          
          bp.results.should eq naturals
        end
      end

    end
    
    context 'bytecode for byte sequences' do
      before :all do
        @byte_sequences = [
          (1..8).to_a,
          (0..100).step(4).to_a.reverse,
        ]
      end
      
      it 'should correctly process bytecode for a byte sequece' do
        @byte_sequences.each do |byte_sequence|
          bytecode = Instructions::ByteSequence.make_into_bytecode byte_sequence
          bp = OOPM::Processing::ByteStreamProcessor.new ArrayStream.new(bytecode)
          bp.process_next.should eq byte_sequence
        end
      end
    end
    
    context 'bytecode for integers' do
      before :all do    
        @integers = [-100, 100, -28555811294, 491847429 ]
      end
      
      it 'should correctly process bytecode for integers' do
        @integers.each do |integer|
          bytecode = Instructions::Integer.make_into_bytecode integer
          bytestream = ArrayStream.new(bytecode)
          bp = OOPM::Processing::ByteStreamProcessor.new bytestream
          bp.process_next.should eq integer
        end
      end
    end
    
    context 'bytecode for reals' do
      before :all do    
        @reals = [-5.678, 200.02, -2855.5811294e33, 4.9184742e120 ]
      end
      
      it 'should correctly process bytecode for real numbers' do
        @reals.each do |real|
          bytecode = Instructions::Real.make_into_bytecode real
          bytestream = ArrayStream.new(bytecode)
          bp = OOPM::Processing::ByteStreamProcessor.new bytestream
          bp.process_next.should eq real
        end
      end
    end

  end
end
