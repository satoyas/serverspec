require 'rake'
require 'rspec/core/rake_task'
require 'highline/import'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  targets = []
  hosts = []

  if ENV['SERVICE'].nil? or ENV['ROLE'].nil? or ENV['HOSTNAME'].nil?
   puts "syntax error" 
   exit;  
  end
  
  service = ENV['SERVICE']
  roles = ENV['ROLE']

  ENV['HOSTNAME'].split(",").each do |h|
     targets << h
  end

#  if ENV['ROLE'].nil? or ENV['ROLE'].empty?
#    Dir.glob("./spec/#{service}/*").each do |dir|
#      next unless File.directory?(dir)
#      roles << File.basename(dir)
#    end
#  else
#    roles.split(",").each do |role|
#     targets << role
#    end 
#  end

  task :all     => targets
  task :default => :all

 if ENV['ASK_LOGIN_PASSWORD'] or  ENV['ASK_LOGIN_PASSWORD'] == "yes"
    ENV['LOGIN_PASSWD'] = ask("Enter login password: ") { |q| q.echo = false }
 end
 
 if ENV['ASK_SUDO_PASSWORD'] or ENV['ASK_SUDO_PASSWORD'] == "yes"
   ENV['SUDO_PASSWD'] =  ask("Enter sudo password: ") { |q| q.echo = false }
 end

  targets.each do |target|
    desc "Run serverspec tests to #{target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      t.pattern = "spec/#{service}/{#{roles}}/*_spec.rb"
    end
  end
end

