require 'nanoc3/tasks'
Dir['tasks/**/*.rake'].sort.each { |rakefile| load rakefile }

task :default => [:compile]
task :rebuild => [:fullclean, :compile]

task :fullclean => :clean do
  system('git', 'clean', '-qdf')
  system('rm', '-r', 'output', 'tmp')
end

task :compile do
  system('nanoc3', 'compile')
end

task :rebuild do
  Rake::Task["fullclean"].invoke
  Rake::Task["compile"].invoke
end

task :build_production do
  system('cp', 'settings/prod.rb', 'settings.rb')
  Rake::Task["rebuild"].invoke
end

task :publish do
  puts "Deploying to PRODUCITON"
  Rake::Task["build_production"].invoke
  system('rake', 'deploy:rsync', 'config=prod')
end
