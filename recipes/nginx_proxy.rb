packages = %w{nginx}

packages.each do |pkg|
  package pkg do
    action :install
    options '--force-yes'
  end
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

# Start Nginx
service "nginx" do
  action :start
end
