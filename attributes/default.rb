default[:elasticsearch] = {
  :cluster => {
    :name => "elasticsearch"
  },
  :version => '1.3.4'
}

# Populate an array with the addresses of other instances in the ES layer
seed_array = []

node["opsworks"]["layers"]["elasticsearch"]["instances"].each do |instance_name, values|
  seed_array << values["private_ip"]
end

hosts_string = "[" + seed_array.map!{|host| "\"#{host}\""}.join(", ") + "]"
  
set[:elasticsearch][:discovery][:zen][:ping][:unicast][:hosts] = seed_array