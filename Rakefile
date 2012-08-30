# encoding: utf-8

require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler."
  exit -1
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard

require "bundler/gem_tasks"

task :make_parsers do
  parsing_path_rel = 'lib/oopm/parsing'
  project_root = Dir.getwd
  
  Dir.chdir parsing_path_rel
  grammars = Dir.glob('*.treetop')
  
  puts "Making parsers from .treetop files in #{project_root}/#{parsing_path_rel}"
  grammars.each do |grammar|
    puts "making parser from #{grammar}"
    `tt #{grammar}`
  end
  
  Dir.chdir project_root
end