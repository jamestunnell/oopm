require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OOPM::Parsing::LiteralParser do
  parser = OOPM::Parsing::LiteralParser.new
  parser.root = :symbol
  
  symbols = [":do_this", ":abc123", ':"123abc"']
  
  symbols.each do |symbol|
    it "should parse #{symbol}" do
      parser.parse(symbol).should be_true
    end
  end
end
