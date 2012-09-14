require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OOPM::Util::UniqueName do
  it "should generate a string containing only letters and digits" do
    1000.times do
      name =  OOPM::Util::UniqueName.new_name
      (name =~ /[a-zA-Z0-9]+/).should be_true
    end
  end

  it "should never make the same name twice" do
    names = []
    1000.times do
      name = OOPM::Util::UniqueName.new_name
      names.include?(name).should be_false
      names << name
    end
  end
end
