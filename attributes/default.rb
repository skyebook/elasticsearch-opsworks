default[:elasticsearch] = {
  :cluster => {
    :name => "elasticsearch"
  },
  :version => '1.3.4'
}

# Populate an array with the addresses of other instances in the ES layer
seed_array = []

# This is kind of hacky, but it reliably gets the OpsWorks layer we are running on (presuming the instance only belongs to a single layer)
node["opsworks"]["instance"]["layers"][0]["instances"].each do |instance_name, values|
  seed_array << values["private_ip"]
end

hosts_string = "[" + seed_array.map!{|host| "\"#{host}\""}.join(", ") + "]"
  
set[:elasticsearch][:discovery][:zen][:ping][:unicast][:hosts] = seed_array