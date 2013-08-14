# Install StreamMachine

package "git"

# -- Create our User -- #

user node.streammachine.user do
  action    :create
  system    true
  shell     "/bin/bash"
  supports  :manage_home => false
end

# -- Create our Log Directory -- #

directory "/var/log/streammachine" do
  action    :create
  mode      0755
  owner     node.streammachine.user
  recursive true
end

# -- Install the code -- #

npm_package "StreamMachine/StreamMachine" do
  action :install
end

# -- Write our config file -- #

# Look for the databag
log "Looking for StreamMachine config in databag #{node.streammachine.databag}/#{node.streammachine.config}"
item = data_bag_item( node.streammachine.databag, node.streammachine.config )

if item && item.has_key?("config")
  # convert config to JSON
  config_json = JSON.pretty_generate item["config"]
  
  # replace our directory
  #config_json.gsub! "!DIR!", node.streammachine.dir
  
  file "/etc/streammachine.json" do
    action  :create
    content config_json
    user    node.streammachine.user
  end

else
  log "Failed to find StreamMachine config at #{node.streammachine.databag}/#{node.streammachine.config}"
end

# -- Install Lifeguard -- #

npm_package "lifeguard" do
  action :install
  version "~0.3.0"
end

# -- Install our Upstart Task -- #

template "/etc/init/streammachine.conf" do
  action  :create_if_missing
  user    "root"
  mode    0644
end


# -- Start the service -- #

