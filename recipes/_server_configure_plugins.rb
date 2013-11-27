# 
# Author:: Paulo Nahes <phnahes@gmail.com>
#
# Cookbook Name:: jenkins
# Recipe:: server_plugins
#
# Copyright 2013, Paulo Nahes.
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
home = node['jenkins']['server']['home']

template "#{home}/jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin.xml" do
  source "plugin-publish-over-ssh.erb"
  owner node['jenkins']['server']['user']
  group node['jenkins']['server']['group']
  mode node['jenkins']['server']['log_dir_permissions']
  variables(
	:name 		=> "#{node['jenkins']['server']['repo']['name']}",
	:hostname 	=> "#{node['jenkins']['server']['repo']['hostname']}",
	:username 	=> "#{node['jenkins']['server']['repo']['username']}",
	:keypath 	=> "#{node['jenkins']['server']['repo']['keypath']}"
  )
end

