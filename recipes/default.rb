#
# Cookbook Name:: elasticsearch-opsworks
# Recipe:: default
#
# Copyright 2014, Skye Book
#
# All rights reserved - Do Not Redistribute
#

# Add ES repository
apt_repository "elasticsearch" do
  uri "http://packages.elasticsearch.org/elasticsearch/1.3/debian"
  components ["stable", "main"]
  key "http://packages.elasticsearch.org/GPG-KEY-elasticsearch"
  
  # Add is actually the default action now, but let's be explicit for clarity
  action :add
end

# Install Java and some niceties
packages = %w{openjdk-7-jre nload iotop htop}

packages.each do |pkg|
  package pkg do
    action :install
    options '--force-yes'
  end
end

# Install ES with the preferred version
package "elasticsearch" do
  version node[:elasticsearch][:version]
  action :install
  options '--force-yes'
end

# Populate config files
template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
end

template "/etc/elasticsearch/logging.yml" do
  source "logging.yml.erb"
end

# Start ES
service "elasticsearch" do
  action :start
end