require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test

task :console do
  require 'irb'
  require 'irb/completion'
  require_relative 'lib/github'
  ARGV.clear
  IRB.start
end
