require 'rubygems'
require 'nanoc3/tasks'

Dir['tasks/**/*.rake'].sort.each { |rakefile| load rakefile }

task :default => [:compile]
task :rebuild => [:fullclean, :compile]

desc "Cleanup git and output dirs"
task :fullclean => :clean do
  #system('git', 'clean', '-qdf')
  system('rm', '-rf', 'output', 'tmp')
end

task :compile do
  system('nanoc', 'compile')
end

task :rebuild do
  Rake::Task["fullclean"].invoke
  Rake::Task["compile"].invoke
end

desc "Setup settings for production"
task :build_production do
  system('cp', 'settings/prod.rb', 'settings.rb')
  Rake::Task["rebuild"].invoke
end

desc "Copy settings file back to development defaults"
task :post_build_production do
  system('cp', 'settings/dev.rb', 'settings.rb')
end

desc "Deploy to staging"
task :publish_stg do
  puts "Deploying to STAGING"
  Rake::Task["build_production"].invoke
  system('nanoc', 'deploy', '--target=stg')
end

desc "Deploy to production"
task :publish do
  puts "Deploying to PRODUCITON"
  Rake::Task["build_production"].invoke
  system('nanoc', 'deploy', '--target=prod')
  Rake::Task["post_build_production"].invoke
end
