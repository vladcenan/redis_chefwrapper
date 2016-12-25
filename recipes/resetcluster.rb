#
# Cookbook Name:: rediscluster
# Recipe:: resetcluster 
#
# All rights reserved - Do Not Redistribute
#
execute 'ruby_env' do 
  command 'export PATH="/opt/chef/embedded/bin:${HOME}/.chef/gem/ruby/2.1.0/bin:$PATH"'
end

node['rediscluster']['resetcluster']['commands'].each do |cmd, options|
  next unless options['enabled']
  execute "#{cmd}_master" do
    sensitive true
    command "#{node.override['redisio']['install_dir']}/src/redis-cli -p #{node['rediscluster']['masterport']} #{options['type']}"
    only_if ("#{node.override['redisio']['install_dir']}/src/redis-cli -p #{node['rediscluster']['masterport']} #{options['type']}")
  end

  execute "#{cmd}_slave" do
    sensitive true
    command "#{node.override['redisio']['install_dir']}/src/redis-cli -p #{node['rediscluster']['slaveport']} #{options['type']}"
    only_if ("#{node.override['redisio']['install_dir']}/src/redis-cli -p #{node['rediscluster']['slaveport']} #{options['type']}")
  end
end
