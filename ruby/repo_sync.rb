#!/usr/bin/env ruby

REPOS = %W[vitrinas-back]

Dir.chdir("#{Dir.home}/work") do
  REPOS.each do |repo_dir|
    Dir.chdir(repo_dir) do
      current_branch = `git branch --show-current`.chomp
      update_message =  "Updating #{repo_dir} | #{current_branch} branch"
      puts update_message
      puts "=" * update_message.length

      puts 'Fetching'
      fetch_status = `git fetch 2>&1`.chomp
      next puts (fetch_status) unless $?.success?

      puts 'Pulling'
      pull_status = `git pull 2>&1`.chomp
      next puts (pull_status) unless $?.success?

      puts 'Pushing to origin'
      push_status = `git push origin #{current_branch} 2>&1`.chomp
      p push_status
      next puts (push_status) unless $?.success?

      puts 'Success' if $?.success?
    end
  end
end
