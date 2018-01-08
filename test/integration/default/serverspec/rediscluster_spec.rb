require 'spec_helper'

describe file('/redis-setup') do
  it { should be_directory }
end

describe service('redis-master'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('redis-slave'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end

describe port(6380) do
  it { should be_listening }
end
