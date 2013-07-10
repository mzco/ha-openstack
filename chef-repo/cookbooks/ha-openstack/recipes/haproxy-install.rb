#
# Cookbook Name:: ha-openstack
# Recipe:: haproxy-install
#
# Copyright 2013, Dell
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


package "haproxy" do
	action :install
end

template '/etc/default/haproxy' do
  	source 'haproxy.init.erb'
  	owner "root"
  	group "root"
  	mode 0644
	notifies :restart, "service[haproxy]"
end

template "#{node['haproxy']['cfg_file']}" do
  	source "haproxy.cfg.erb"
  	owner "root"
  	group "root"
  	mode 00644
  	notifies :reload, "service[haproxy]"
end

cfgs = data_bag('haproxy')
cfgs.each do |list|
	map = data_bag_item('haproxy', list)
	#node[:frontend] = "#{cfg['frontend']}"
	map_frontend = map['frontend']
	map_frontend.each_key do |f_ip|
		port = map_frontend[f_ip]
		bash "Add Front-End" do
			user "root"
			code <<-EOH
echo "frontend #{list}
  maxconn 4000
  bind #{f_ip}:#{port}
  default_backend servers-#{list}
" >> #{node['haproxy']['cfg_file']}
			EOH
		end
	end
	bash "Add Back-End: Title" do
		user "root"
		code <<-EOH
echo "backend servers-#{list}" >> #{node['haproxy']['cfg_file']}
		EOH
	end
	map_backend = map['backend']
	map_backend.each_key do |b_ip|
		port = map_backend[b_ip]
		bash "Add Back-End: Servers" do
			user "root"
			code <<-EOH
echo "  server #{b_ip} #{b_ip}:#{port} weight 1 maxconn #{node['haproxy']['member_max_connections']} check" >> #{node['haproxy']['cfg_file']}
			EOH
		end
	end
	bash "Add Back-End: End" do
		user "root"
		code <<-EOH
echo >> #{node['haproxy']['cfg_file']}
		EOH
	end
end

service "haproxy" do
  	supports :restart => true, :status => true, :reload => true
  	action [:enable, :start]	
	subscribes :reload, resources("template[#{node['haproxy']['cfg_file']}]")
end




