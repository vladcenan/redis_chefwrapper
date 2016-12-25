#
# Cookbook Name:: rediscluster
# Recipe:: install 
#
# All rights reserved - Do Not Redistribute
#
directory "#{node['rediscluster']['download_dir']}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

redis = node['redisio']
location = "#{redis['mirror']}/#{redis['base_name']}#{redis['version']}.#{redis['artifact_type']}"

redisio_install 'redis-installation' do
  version redis['version'] if redis['version']
  download_url location
  safe_install redis['safe_install']
  install_dir redis['install_dir'] if redis['install_dir']
  download_dir "#{node['rediscluster']['download_dir']}"
end
