default[:elasticsearch] = {
  :auth => {
    :username => "elasticsearch_user",
    :password => "elasticsearch_password"
  },
  :cluster => {
    :name => "elasticsearch"
  },
  :version => '1.3.4',
  :path => {
  	:logs => "/var/log/elasticsearch",
  	:data => "/var/data/elasticsearch"
  },
  :ssl => {
  	:cert => nil,
  	:key => nil
  }
}

# Populate an array with the addresses of other instances in the ES layer
seed_array = []

# Include this instance in the seed list
seed_array << node["opsworks"]["instance"]["private_ip"]

# This is kind of hacky, but it reliably gets the OpsWorks layer we are running on (presuming the instance only belongs to a single layer)
layer = node["opsworks"]["instance"]["layers"][0]
node["opsworks"]["layers"][layer]["instances"].each do |instance_name, values|
  seed_array << values["private_ip"].gsub("\"", "")
end

puts "******* SEED ARRAY: #{seed_array} "

hosts_string = "[" + seed_array.map!{|host| "\"#{host}\""}.join(", ") + "]"
  
set[:elasticsearch][:discovery][:zen][:ping][:unicast][:hosts] = seed_array

# Create HTPasswd
command = "printf \""+node["elasticsearch"]["auth"]["username"]+":$(openssl passwd -apr1 "+node["elasticsearch"]["auth"]["password"]+")\""
set[:elasticsearch][:auth][:htpasswd] = `#{command}`