#
# Cookbook Name:: rediscluster
# Recipe:: redisdb 
#
# All rights reserved - Do Not Redistribute
#
template "/#{node.override['redisio']['install_dir']}/redis-master.conf" do
  source 'redis-master.conf.erb'
  owner 'root'
  group 'root'
  mode '0664'
end

template "/#{node.override['redisio']['install_dir']}/redis-slave.conf" do
  source 'redis-slave.conf.erb'
  owner 'root'
  group 'root'
  mode '0664'
end

template '/etc/rc.d/init.d/redis-master' do
  source 'redis-master.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :masterport => node['rediscluster']['masterport'] 
  ) 
end

template '/etc/rc.d/init.d/redis-slave' do
  source 'redis-slave.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :slaveport => node['rediscluster']['slaveport']
  )
end

template "/#{node.override['redisio']['install_dir']}/src/redis-trib.rb" do
  source 'redis-trib.rb.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template "/#{node.override['redisio']['install_dir']}/clusterstatus.sh" do
  source 'clusterstatus.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'redis-master' do
  supports :stop => true, :start => true, :restart => true
  action [:enable, :start]
end

service 'redis-slave' do
  supports :stop => true, :start => true, :restart => true
  action [:enable, :start]
end
