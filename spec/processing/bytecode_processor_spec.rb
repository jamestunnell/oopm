require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'pry'
describe OOPM::Processing::BytecodeProcessor do
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
          bp = OOPM::Processing::BytecodeProcessor.new
          bytes = Instructions::Natural.make_bytecode natural
          bp.process_bytecode bytes, 0
          bp.results.first.should eq natural
        end
      end

      it 'should correctly process bytecode for multiple natural numbers' do
        @multiple_naturals.each do |naturals|
          bp = OOPM::Processing::BytecodeProcessor.new
          
          bytes = []
          naturals.each do |natural|
            bytes += Instructions::Natural.make_bytecode natural
          end
          
          offset = 0
          naturals.count.times do
            offset = bp.process_bytecode bytes, offset
          end
          
          bp.results.should eq naturals
        end
      end

    end
  end
end
