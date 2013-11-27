# 
# Author:: Seth Chisamore <schisamo@opscode.com>
#
# Cookbook Name:: jenkins
# Recipe:: node
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

include_recipe "jenkins::_node_#{node['jenkins']['node']['agent_type']}"

# Extra Packages
#
pack_list = node['jenkins']['node']['extras']['packages']
pack_list.each do |pkg|
  package pkg do
    options "--force-yes"
    ignore_failure true
  end
end

# Ruby
#
if node['jenkins']['node']['extras']['use_ruby']
	include_recipe "jenkins::_extras_ruby"
end

# Maven
#
if node['jenkins']['node']['extras']['use_maven']
	include_recipe "jenkins::_extras_maven"
end

# Ant
#
if node['jenkins']['node']['extras']['use_ant']
	include_recipe "jenkins::_extras_ant"
end

# Git Checkout
#
if node['jenkins']['node']['extras']['use_git']
	include_recipe "jenkins::_extras_git"
end
