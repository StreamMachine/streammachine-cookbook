# -- Install ffmpeg -- #

# This is an interim measure. Compiling all this from source is way, way too
# slow to be flexible, but there isn't necessarily a great source to find the
# options we need

# Install yasm 1.2.0

package "checkinstall"

bash "compile_yasm_1.2.0" do
  cwd "/tmp"
  code <<-EOH
    apt-get build-dep yasm
    wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
    tar xvfz yasm-1.2.0.tar.gz
    cd yasm-1.2.0
    ./configure --prefix=/usr
    checkinstall --pakdir /tmp --pkgname yasm --pkgversion 1.2.0 --backup=no --default
  EOH
  not_if do
     File.exists?("/usr/bin/yasm") && (`/usr/bin/yasm --version` =~ /yasm 1\.2\.0/)
   end
end

# Install libfdk

bash "compile_libfdk" do
  cwd "/tmp"
  code <<-EOH
    wget http://downloads.sourceforge.net/opencore-amr/fdk-aac-0.1.3.tar.gz
    tar xvfz fdk-aac-0.1.3.tar.gz
    cd fdk-aac-0.1.3
    ./configure --prefix=/usr
    checkinstall --pakdir /tmp --pkgname fdk-aac --pkgversion 0.1.3 --backup=no --default
  EOH
  creates "/usr/lib/libfdk-aac.so.0.0.4"
end

# -- add multiverse -- #

# libfaac-dev, required by ffmpeg, only exists in the multiverse packaging
# for precise

include_recipe "apt"

apt_repository 'precise-multiverse' do
  uri          'http://us.archive.ubuntu.com/ubuntu'
  distribution "precise"
  components   ['multiverse']
  deb_src      true
  notifies :run, "execute[apt-get update]", :immediately
  not_if do
    `grep -e "^[^#].* precise multiverse" /etc/apt/sources.list`
  end
end

apt_repository 'precise-updates-multiverse' do
  uri          'http://us.archive.ubuntu.com/ubuntu'
  distribution "precise-updates"
  components   ['multiverse']
  deb_src      true
  notifies :run, "execute[apt-get update]", :immediately
  not_if do
    `grep -e "^[^#].* precise-updates multiverse" /etc/apt/sources.list`
  end
end

# Compile ffmpeg

include_recipe "ffmpeg::source"
