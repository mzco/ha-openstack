#
# Cookbook Name:: ha-openstack
# Recipe:: haproxy-uninstall
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


# check whether already installed
if ::File.exists?("/etc/init.d/haproxy")

	# stop and disable proxy
	service "haproxy" do
		action [:stop, :disable]
	end

	# purge packages
	package "haproxy" do	
		action :remove
	end

end

