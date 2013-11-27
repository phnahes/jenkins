home = node['jenkins']['server']['home']
cli_jar = ::File.join(home, 'jenkins-cli.jar')

remote_file cli_jar do
	source "#{node['jenkins']['server']['url']}/jnlpJars/jenkins-cli.jar"
	not_if { ::File.exists?(cli_jar) }
end

#search(:jenkins, "type:#{tipo} AND envWP:blogs") do |item|
search(:jenkins) do |item|
	jobName 	= item['jobName']
	templateName 	= item['template']
	id	 	= item['id']
	view	 	= item['viewName']
	
	directory "#{home}/jobs/#{jobName}" do
		recursive true
		owner "#{node['jenkins']['server']['user']}"
		group "#{node['jenkins']['server']['group']}"
		mode "0755"
		action :create
		not_if "test -d #{home}/jobs/#{jobName}"
	end

	template "#{home}/jobs/#{jobName}/config.xml" do
		source "template-jobs/#{templateName}.xml.erb"
		owner "#{node['jenkins']['server']['user']}"
		group "#{node['jenkins']['server']['group']}"
		mode "0644"
		
		variables(
			:id 		=> id,
			:name 		=> jobName,
			:fullname 	=> "#{item["envWP"]}-#{item["type"]}-#{item["id"]}",
			:template 	=> templateName,
			:description 	=> "#{item['description']}",
			:numToKeep 	=> item["numToKeep"],
			:daysToKeep 	=> item["daysToKeep"],
			:giturl 	=> item['giturl'],
			:branch 	=> item['branch'],
			:target 	=> item['target'],
			:buildFile 	=> item['buildFile'],
			:use_artifacts 	=> item['use_artifacts'],
			:artifacts 	=> item['artifacts'],
			:repoName 	=> item['repoName'],
			:sourceFiles 	=> item['sourceFiles'],
			:timeout 	=> item['timeout'],
			:shellCommand 	=> item['shellCommand'],
			:type 		=> item["type"],
			:path 		=> item["path"],
			:envWP 		=> item["envWP"],
			:file 		=> item["file"],
			:project 	=> item["project"],
			:subdir 	=> item["subdir"],
			:assignedNode 	=> item["assignedNode"]
		)

		notifies :run, "execute[reload-configuration]", :delayed

	end

end

execute "reload-configuration" do
  command "/usr/bin/java -jar #{home}/jenkins-cli.jar -s #{node['jenkins']['server']['url']} reload-configuration" #--username deployer --password-file #{node['jenkins']['server']['home']}/deployer/deployer_pass"
  action :run
end

search(:jenkins) do |item|
	jobName 	= item['jobName']
	templateName 	= item['template']
	id	 	= item['id']
	view	 	= item['viewName']

	if defined? view
		if not view.to_s.empty?
			jenkinsng_view "#{id}" do
				view "#{view}"
				job "#{jobName}"
			end
		end
	end
end
