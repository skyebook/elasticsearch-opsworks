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

# Install Nginx, and some niceties
packages = %w{nginx nload iotop htop}

# Install Java

execute "add oracle java repo" do
    command '/usr/bin/add-apt-repository -y ppa:webupd8team/java && /usr/bin/apt-get update'
    not_if "test -x /etc/apt/sources.list.d/webupd8team-java-precise.list"
end
execute "accept-license" do
  command "echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
end

package "oracle-java7-installer"
package "oracle-java7-set-default"


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

execute "chown ES data path" do
  command "chown -R root:elasticsearch #{node[:elasticsearch][:path][:data]}"
  user "root"
  action :run
end

execute "chmod ES data path" do
  command "chmod -R g+w #{node[:elasticsearch][:path][:data]}"
  user "root"
  action :run
end


if node[:elasticsearch][:ssl][:cert]
  template "/etc/nginx/ssl/cert.pem" do
    source "cert.pem.erb"
    mode "644"
  end

  template "/etc/nginx/ssl/cert.key" do
    source "cert.key.erb"
    mode "644"
  end
end

# Start ES
#service "elasticsearch" do
#  action :start
#end

execute "add init script to system startup" do
  command "update-rc.d elasticsearch defaults"
  user "root"
  action :run
end

execute "init ES"
  command "/etc/init.d/elasticsearch start" do
  user "root"
  action :run
end

# Start Nginx
service "nginx" do
  action :start
end