require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::LiteralParser do
  before(:each) do
    @parser = OOPM::Parsing::LiteralParser.new
    @parser.root = :name
  end
  
  describe "parses strings starting with a letter or underscore and followed by valid characters thereafter" do
    valid_start_chars = ['a', 'A', '_']
    valid_content_segments = ['', 'abc', 'ABC', '123', '___']
    
    valid_start_chars.each do |start_str|
      valid_content_segments.each do |l_content_str|
        valid_content_segments.each do |r_content_str|
          str = start_str + l_content_str + r_content_str
          
          it "should parse #{str}" do
            @parser.parse(str).should be_true
          end
        end
      end
    end
  end

  describe "does not parse strings starting with !(letter or underscore)" do
    invalid_start_chars = ['1', '.', '(', '+']
    valid_content_segments = ['', 'abc', 'ABC', '123', '___']
    
    invalid_start_chars.each do |start_str|
      valid_content_segments.each do |l_content_str|
        str = start_str + l_content_str
        
        it "should not parse #{str}" do
          @parser.parse(str).should be_nil
        end
      end
    end
  end
  
  describe "does not parse strings containing a non-word character" do
    valid_start_chars = ['a', 'A', '_']
    valid_content_segments = ['', 'abc', 'ABC', '123', '___']
    non_word_chars = [' ', '.', '(', '+', ':']
    
    valid_start_chars.each do |start_str|
      non_word_chars.each do |non_word_char|
        valid_content_segments.each do |content_str|
          str = start_str + non_word_char + content_str
        
          it "should not parse #{str}" do
            @parser.parse(str).should be_nil
          end
        end
      end
    end
  end
  
  describe "does not parse strings ending in a non-word character" do
    valid_start_chars = ['a', 'A', '_']
    valid_content_segments = ['', 'abc', 'ABC', '123', '___']
    non_word_chars = [' ', '.', '(', '+', ':']
    
    valid_start_chars.each do |start_str|
      valid_content_segments.each do |content_str|
        non_word_chars.each do |non_word_char|
          str = start_str + content_str + non_word_char
        
          it "should not parse #{str}" do
            @parser.parse(str).should be_nil
          end
        end
      end
    end
  end
end
