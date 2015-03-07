require 'serverspec'
require 'net/ssh'

set :backend, :ssh


host = ENV['HOSTNAME']
#host = ENV[TARGET_HOST]

options = Net::SSH::Config.for(host)

if ENV['USER'].nil?   
 options[:user] ||= Etc.getlogin
else
 options[:user] ||= ENV['USER']
end

if !ENV['LOGIN_PASSWD'].nil?
   options[:password] = ENV['LOGIN_PASSWD'] 
end

if !ENV['SUDO_PASSWD'].nil?
  set :sudo_password, ENV['SUDO_PASSWD']
end 

set :host,        options[:host_name] || host
set :ssh_options, options
set :request_pty, true

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C' 

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
