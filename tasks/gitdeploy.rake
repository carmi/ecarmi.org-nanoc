require 'rake'

desc "Deploy the master git branch to prod and develop branch to staging"
task :gitdeploy do
  cmd = `git checkout develop`
  if $? == 0
    puts `rake deploy:rsync config=staging`
  else
    puts "Failed: #{cmd}"
  end

  cmd = `git checkout master`
  if $? == 0
    puts `rake deploy:rsync config=prod`
  else
    puts "Failed: #{cmd}"
  end
  `git checkout develop`
end
