#
# Cookbook Name:: rediscluster
# Recipe:: default
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'redisio::_install_prereqs'
include_recipe 'build-essential::default'
include_recipe 'rediscluster::install'
include_recipe 'rediscluster::redisdb'
