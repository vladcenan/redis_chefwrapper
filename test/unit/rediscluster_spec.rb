require_relative 'spec_helper'

describe 'rediscluster' do

  let(:chef_run) {
    ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5') do |node|
      env = Chef::Environment.new
      env.name 'SPEC'
      allow(node).to receive(:chef_environment).and_return env.name
      allow(Chef::Environment).to receive(:load).and_return env
      node.set['rediscluster']['version'] = '3.2.5'
    end.converge(described_recipe)
  }

  it 'Creates redis install directory' do
    expect(chef_run).to create_directory('/redis-setup')
  end
  
  it 'enable service' do
    expect(chef_run).to enable_service('redis-master')
  end

  it 'enable service' do
    expect(chef_run).to enable_service('redis-slave')
  end

  it 'creates a template redis master init' do
    expect(chef_run).to create_template('/etc/rc.d/init.d/redis-master')
  end

  it 'creates a template redis slave init' do
    expect(chef_run).to create_template('/etc/rc.d/init.d/redis-slave')
  end

  it 'creates a template redis master conf' do
    expect(chef_run).to create_template('//redis-setup/redis-3.2.5/redis-master.conf')
  end

  it 'creates a template redis slave conf' do
    expect(chef_run).to create_template('//redis-setup/redis-3.2.5/redis-slave.conf')
  end

  it 'creates a template redis trib' do
    expect(chef_run).to create_template('//redis-setup/redis-3.2.5/src/redis-trib.rb')
  end

  it 'creates a template redis cluster status' do
    expect(chef_run).to create_template('//redis-setup/redis-3.2.5/clusterstatus.sh')
  end

  it 'creates a template redis logrotate' do
    expect(chef_run).to create_template('/etc/logrotate.d/redis')
  end
end
