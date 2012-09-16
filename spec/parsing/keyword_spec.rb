require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Parsing::KeywordParser do
  keywords = ["if", "end", "def", "class", "module", "then",
  "unless", "raise", "return", "do", "ifels", "else", "require", "include"]

  before(:each) do
    @parser = OOPM::Parsing::KeywordParser.new
  end

  it "should parse keywords" do
    keywords.each do |keyword|
      @parser.parse(keyword).should be_true
    end
  end
end
