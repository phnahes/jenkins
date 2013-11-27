#
# Cookbook Name:: jenkins
# Attributes:: node
#
# Author:: Doug MacEachern <dougm@vmware.com>
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Seth Chisamore <schisamo@opscode.com>
#
# Copyright 2010, VMware, Inc.
# Copyright 2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'windows'
  default['jenkins']['node']['home'] = 'C:/jenkins'
  default['jenkins']['node']['log_dir']  = 'C:/jenkins'
  default['jenkins']['node']['agent_type'] = 'windows'

  default['jenkins']['node']['service_user'] = 'LocalSystem'
  default['jenkins']['node']['service_user_password'] = nil
  default['jenkins']['node']['winsw_url'] = 'http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/1.13/winsw-1.13-bin.exe'
when 'mac_os_x'
  default['jenkins']['node']['home'] = '/Users/jenkins'
  default['jenkins']['node']['log_dir']  = '/var/log/jenkins'
  default['jenkins']['node']['agent_type'] = 'jnlp'
else
  default['jenkins']['node']['home'] = '/var/lib/jenkins'
  default['jenkins']['node']['log_dir']  = '/var/log/jenkins'
  default['jenkins']['node']['agent_type'] = 'jnlp'
end

default['jenkins']['node']['user'] = 'jenkins'
default['jenkins']['node']['group'] = 'users'
default['jenkins']['node']['shell'] = '/bin/bash'
default['jenkins']['node']['name'] = node['fqdn']
default['jenkins']['node']['description'] =
  "#{node['platform']} #{node['platform_version']} " <<
  "[#{node['kernel']['os']} #{node['kernel']['release']} #{node['kernel']['machine']}] " <<
  "slave on #{node['hostname']}"
default['jenkins']['node']['labels'] = (node['tags'] || [])

default['jenkins']['node']['env'] = nil
default['jenkins']['node']['jvm_options'] = nil
default['jenkins']['node']['executors'] = 10
default['jenkins']['node']['in_demand_delay'] = 0
default['jenkins']['node']['idle_delay'] = 1

# Usage
#    normal - Utilize this slave as much as possible
#    exclusive - Leave this machine for tied jobs only
default['jenkins']['node']['mode'] = 'normal'

# Availability
#    always - Keep this slave on-line as much as possible
#    demand - Take this slave on-line when in demand and off-line when idle
default['jenkins']['node']['availability'] = 'always'

# SSH options
default['jenkins']['node']['ssh_host'] = node['fqdn']
default['jenkins']['node']['ssh_port'] = 22
default['jenkins']['node']['ssh_user'] = default['jenkins']['node']['user']
default['jenkins']['node']['ssh_pass'] = nil
default['jenkins']['node']['ssh_private_key'] = nil

# Extra Packages
default['jenkins']['node']['extras']['packages'] = ["git", "rpm", "debhelper", "python-setuptools", "python-dev"]

# Ruby Options
default['jenkins']['node']['extras']['use_ruby'] = true
default['jenkins']['node']['extras']['ruby_pkgs'] = ["libbundler-ruby1.9.1", "ruby1.9.1-dev", "rake"]

# Maven Options
default['jenkins']['node']['extras']['use_maven'] = true
default['jenkins']['node']['extras']['archiva_url'] = "archiva.com"
default['jenkins']['node']['extras']['archiva_user'] = "user"
default['jenkins']['node']['extras']['archiva_pass'] = "pass"
default['jenkins']['node']['extras']['maven_pkgs'] = ["maven2", "default-jdk"]

# Ant Options
default['jenkins']['node']['extras']['use_ant'] = true
default['jenkins']['node']['extras']['jar_path'] = "/usr/share/java"
default['jenkins']['node']['extras']['ant_path'] = "/usr/share/ant/lib"
default['jenkins']['node']['extras']['ant_pkgs'] = ["ant", "default-jdk"]


# Git Options
default['jenkins']['node']['extras']['use_git'] = false
