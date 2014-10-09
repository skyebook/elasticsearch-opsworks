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

# Install Java, Nginx, and some niceties
packages = %w{openjdk-7-jre nginx nload iotop htop}

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

template "/etc/nginx/sites-available/default" do
  source "nginx-site.erb"
end

template "/etc/nginx/sites-available/default" do
  source "nginx-site.erb"
end

template "/etc/nginx/conf.d/elasticsearch.htpasswd" do
  source "elasticsearch.htpasswd.erb"
  mode "644"
end

# Create the SSL directory before dropping templates in
directory "/etc/nginx/ssl" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

template "/etc/nginx/ssl/cert.pem" do
  source "cert.pem.erb"
  mode "644"
end

template "/etc/nginx/ssl/cert.key" do
  source "cert.key.erb"
  mode "644"
end

# Start ES
service "elasticsearch" do
  action :start
end

# Start Nginx
service "nginx" do
  action :start
end