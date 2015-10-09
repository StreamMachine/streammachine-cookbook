require "spec_helper"

# Node should be installed and should run
describe command("node -v") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /^v\d+\.\d+\.\d+/ }
end

# the streammachine command should be available in /usr/bin
describe file("/usr/bin/streammachine") do
  it { should exist }
  it { should be_symlink }
end

# streammachine should have a config in /etc
describe file("/etc/streammachine.json") do
  it { should be_file }
  its(:content) { should include('"port": 8001') }
end

# streammachine should be running, via the runner
describe service("StreamR") do
  it { should be_running }
end

describe service("StreamMachine") do
  it { should be_running }
end

# streammachine should be listening on ports 8001 and 8002

describe port(8001) do
  it { should be_listening }
end

describe port(8002) do
  it { should be_listening }
end
