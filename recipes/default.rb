# Install StreamMachine

include_recipe "nodejs"
include_recipe "lifeguard"

include_recipe "git"

if node.streammachine.install_ffmpeg
  include_recipe "streammachine::ffmpeg"
end

if node.streammachine.install_redis
  include_recipe "streammachine::install_redis"
end

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

# Install StreamMachine, unless we already have the version requested

source = (node.streammachine.version.to_sym == :master) ? "StreamMachine/StreamMachine" : "streammachine@#{node.streammachine.version}"

execute "npm install -g #{source}" do
  #environment({
  #  "PATH" => "/usr/bin:/usr/local/bin"
  #})

  not_if do
    if node.streammachine.version.to_sym == :master
      false
    else
      json = `npm list -g streammachine --json`
      begin
        obj = JSON.parse json

        if obj["dependencies"] && obj["dependencies"]["streammachine"]["version"] == node.streammachine.version
          true
        else
          false
        end
      rescue
        false
      end
    end
  end
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

# -- Install our Upstart Task -- #

#template "/etc/init/streammachine.conf" do
#  action  :create_if_missing
#  user    "root"
#  mode    0644
#end

# -- Start the service -- #

lifeguard_service "StreamMachine" do
  action  [:enable,:start]
  service "streammachine"
  command "/usr/bin/env streammachine --config /etc/streammachine.json"
  user    node.streammachine.user
  handoff true
end
