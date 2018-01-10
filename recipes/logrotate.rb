#
# Cookbook Name:: rediscluster
# Recipe:: logrotate
#
# All rights reserved - Do Not Redistribute
#
template '/etc/logrotate.d/redis' do
  source 'redis-logrotate.erb'
  group 'root'
  owner 'root'
  variables(
    :logfiles => [node['rediscluster']['masterlog'], node['rediscluster']['slavelog']]
  )
  mode 0755
end
