#
# Cookbook Name::rediscluster
# Attributes::rediscluster
#
# Redis Install attributes
default['rediscluster']['version'] = '3.2.5'
default['rediscluster']['download_dir'] = '/redis-setup'
default['rediscluster']['masterport'] = 6379
default['rediscluster']['slaveport'] = 6380
default['rediscluster']['cluster-node-timeout'] = 20000
default['rediscluster']['cluster-slave-validity-factor'] = 2
default['rediscluster']['auto-aof-rewrite-percentage'] = 30

# Override RedisIO attributes
node.override['redisio']['version'] = "#{node['rediscluster']['version']}"
node.override['redisio']['install_dir'] = "#{default['rediscluster']['download_dir']}/redis-#{node.override['redisio']['version']}"
node.override['redisio']['default_settings']['homedir'] = "#{default['rediscluster']['download_dir']}/redis-#{node.override['redisio']['version']}"
node.override['redisio']['default_settings']['configdir'] = "#{default['rediscluster']['download_dir']}/redis-#{node.override['redisio']['version']}"
node.override['redisio']['default_settings']['datadir'] = "#{default['rediscluster']['download_dir']}/redis-#{node.override['redisio']['version']}"
node.override['redisio']['bin_path'] = "#{default['rediscluster']['download_dir']}/redis-#{node.override['redisio']['version']}"

# Reset cluster commands
default['rediscluster']['resetcluster']['commands'] =
  {
    'config' => { 'enabled' => true, 'type' => 'config set slave-read-only no' },
    'flush' => { 'enabled' => true, 'type' => 'FLUSHALL' },
    'reset' => { 'enabled' => true, 'type' => 'CLUSTER RESET' }
  }

# Zabbix attributes
default['rediscluster']['zabbix']['zabbix_server_url'] = nil
default['rediscluster']['zabbix']['zabbixapi_gem_version'] = '2.4.8'
default['rediscluster']['zabbix']['hostgroup'] = nil
default['rediscluster']['zabbix']['port'] = 10_050
default['rediscluster']['zabbix']['release'] = nil
