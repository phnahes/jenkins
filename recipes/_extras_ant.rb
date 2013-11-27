#
# Author:: Paulo Nahes <phnahes@gmail.com>
#
# Cookbook Name:: jenkins
# Recipe:: extras_ant
#
# Copyright 2013, Opscode, Inc.
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

# Ant
#
pack_list = node['jenkins']['node']['extras']['ant_pkgs']
pack_list.each do |pkg|
  package pkg do
    options "--force-yes"
    ignore_failure true
  end
end

template "#{node['jenkins']['node']['home']}/hudson.tasks.Ant.xml" do
	source "ant/hudson.tasks.Ant.xml.erb"
	owner node['jenkins']['node']['user']
	group node['jenkins']['node']['group']
	mode '0644'
end

# Ivy jar
cookbook_file "#{node['jenkins']['node']['extras']['jar_path']}/ivy-2.2.0.jar" do
	source "jar/ivy-2.2.0.jar"
	owner 'root'
	group 'root'
	mode '0644'
end
link "#{node['jenkins']['node']['extras']['ant_path']}/ivy-2.2.0.jar" do
	to "#{node['jenkins']['node']['extras']['jar_path']}/ivy-2.2.0.jar"
end
