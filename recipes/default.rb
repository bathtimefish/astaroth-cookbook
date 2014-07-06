#
# Author:: BathTimeFish (<muraoka@bathtimefish.com>)
# Cookbook Name:: astaroth
# Attributes:: default
#
# Copyright 2014, BathTimeFish.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['platform_family']
when 'debian', 'ubuntu'
  # setup snort
  template "/etc/snort/snort.debian.conf" do
    source "snort.debian.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end
  template "/etc/snort/snort.conf" do
    source "snort.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end
  execute "stop snort" do
    command "service snort stop"
    notifies :run, "execute[start snort]", :immediately
  end
  execute "start snort" do
    command "service snort start"
    action :nothing
  end
  # setup metasploit
  execute "clone metasploit" do
    command "git clone https://github.com/darkoperator/MSF-Installer.git /tmp/MSF-Installer"
    action :run
    #notifies :run, "execute[install metasploit]", :immediately
  end
  #if File.exists?('/tmp/MSF-Installer/msf_install.sh')
    bash "install metasploit" do
      user "root"
      cwd "/tmp/MSF-Installer"
      code <<-EOH
        /tmp/MSF-Installer/msf_install.sh -i
      EOH
    end
  #end
  #execute "install metasploit" do
  #  command "/tmp/MSF-Installer/msf_install.sh -i"
  #  action :nothing
  #end
end
#when 'mac_os_x'
#end
