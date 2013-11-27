case node['platform']
  when "ubuntu"
    apt_repository "redis-server" do
      uri           'http://ppa.launchpad.net/chris-lea/redis-server/ubuntu'
      distribution  node['lsb']['codename']
      components    ['main']
      keyserver     "keyserver.ubuntu.com"
      key           "C7917B12"
      action        :add
    end
    
    package "redis-server"
    
  when "centos"
    package "redis"
    
  else
    
end

# -- Install an admin user -- #

execute "install-admin-user" do
  action    :run
  command   "redis-cli hset users admin '#{node.streammachine.admin_password}'"
  #only_if   { `redis-cli hexists users admin` == "0" }
end