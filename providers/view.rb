#
# Cookbook Name:: jenkins
# Provider:: view
#
# Author:: Paulo Nahes <phnahes@gmail.com>
#
# Copyright:: 2013, Paulo Nahes
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

def load_current_resource
  @current_resource = Chef::Resource::JenkinsngView.new(@new_resource.name)
  @current_resource
end

def action_update
  action_create
end

def action_create

  script = "#{node['jenkins']['node']['home']}/manage_view.groovy"

  if not ::File.exists?("#{script}")
	  cookbook_file "#{script}" do
	    source 'manage_view.groovy'
	    cookbook 'jenkinsng'
	    action :create_if_missing
	  end
  end

  if not ::File.exists?("/var/tmp/#{new_resource.job}")
  	jenkinsng_cli "groovy manage_view.groovy #{new_resource.job} #{new_resource.view}"

	file "/var/tmp/#{new_resource.job}" do
		action :create
	end
  end

end
 
#def action_delete
#  jenkinsng_cli "delete-node #{new_resource.name}"
#end
