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

#
# Generate Parsers
#

task :make_parsers do
  parsing_path_rel = 'lib/oopm/parsing'
  project_root = Dir.getwd
  
  Dir.chdir parsing_path_rel
  #grammars = Dir.glob('*.treetop')
  grammars = ['number.treetop','name.treetop','string_literal.treetop','any_object.treetop','expression.treetop']
  
  puts "Making parsers from grammar files:"
  grammars.each do |grammar|
    puts "making parser from #{grammar}"
    `tt #{grammar}`
  end
  
  Dir.chdir project_root
end

#
# Gem Build/Install
#

require 'rubygems/package_task'

spec = Gem::Specification.load(Dir['*.gemspec'].first)
gem = Gem::PackageTask.new(spec)

desc "build the gem file"
task :build => :make_parsers do
  gem.define
end

def is_installed? gem_name
  !(`gem list --local`.scan(gem_name).empty?)
end

desc "install gem locally"
task :install_local => :build do
  #only uninstall if found
  if is_installed? spec.name
    print 'Found gem, uninstalling...'
    `sudo gem uninstall #{gem.gem_spec.name}`
    puts 'done.'
  end

  print 'Installing gem...'
  `sudo gem install #{gem.package_dir_path}`
  puts 'done.'
end