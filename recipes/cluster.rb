#
# Cookbook Name:: rediscluster
# Recipe:: cluster 
#
# All rights reserved - Do Not Redistribute
#
execute 'ruby_env' do 
  command 'export PATH="/opt/chef/embedded/bin:${HOME}/.chef/gem/ruby/2.1.0/bin:$PATH"'
end

execute 'install redis gem' do
  command 'gem install redis'
  not_if 'gem list | grep redis'
end

members = search("node", "recipe:rediscluster AND chef_environment:#{node.chef_environment}") || []
nodez = members.map do |node|
          node["ipaddress"]
        end

execute 'create_cluster' do
  sensitive true
  command "yes 'yes' | #{node.override['redisio']['install_dir']}/src/redis-trib.rb create --replicas 1 #{nodez[0]}:#{node['rediscluster']['masterport']} #{nodez[1]}:#{node['rediscluster']['masterport']} #{nodez[2]}:#{node['rediscluster']['masterport']} #{nodez[0]}:#{node['rediscluster']['slaveport']} #{nodez[1]}:#{node['rediscluster']['slaveport']} #{nodez[2]}:#{node['rediscluster']['slaveport']}"
end
