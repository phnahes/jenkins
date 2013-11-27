#
# Author:: Paulo Nahes <phnahes@gmail.com>
#
# Cookbook Name:: jenkins
# Recipe:: extras_maven
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

# Maven
#
pack_list = node['jenkins']['node']['extras']['maven_pkgs']
pack_list.each do |pkg|
  package pkg do
    options "--force-yes"
    ignore_failure true
  end
end

directory "#{node['jenkins']['node']['home']}/.m2" do
	owner node['jenkins']['node']['user']
	group node['jenkins']['node']['group']
	mode '0755'
end

template "#{node['jenkins']['node']['home']}/.m2/settings.xml" do
	source "maven/settings.xml.erb"
	owner node['jenkins']['node']['user']
	group node['jenkins']['node']['group']
	mode '0644'
	variables(
	    :url	=> node['jenkins']['node']['extras']['archiva_url'],
	    :user	=> node['jenkins']['node']['extras']['archiva_user'],
	    :pass	=> node['jenkins']['node']['extras']['archiva_pass']
	)
end
