#
# Cookbook Name:: ha-openstack
# Recipe:: apply-new-branding
#
# Copyright 2013, DELL
#
# All rights reserved - Do Not Redistribute
#

#OPENSTACK_TYPE = "ubuntu" 
OPENSTACK_TYPE = "dev_stack" 

DASHBOARD_DIR = node[:horizon_dashboard_dir]["#{OPENSTACK_TYPE}"]
TEMPLATE_DIR = node[:horizon_template_dir]["#{OPENSTACK_TYPE}"]

# Move resource files
cookbook_file "#{DASHBOARD_DIR}/img/dell_power.gif" do
	source "img/dell/dell_power.gif"
	owner node[:openstack][:user]
  	group node[:openstack][:user]
	mode 0664
  	action :create_if_missing
end

# Create CSS folder 
directory "#{DASHBOARD_DIR}/css" do
	owner node[:openstack][:user]
  	group node[:openstack][:user]
  	mode 0775
  	action :create
end

# Move custom CSS file
cookbook_file "#{DASHBOARD_DIR}/css/custom.css" do
	source "css/kentucky/custom.css"
	owner node[:openstack][:user]
  	group node[:openstack][:user]
	mode 0664
  	action :create_if_missing
end

# Modify stylesheets template to include custom CSS
ruby_block "modify stylesheets template" do
    block do
      	require 'fileutils'
      	tempfile = File.new("_stylesheets.html", "w")
	FileUtils.chmod(0664, tempfile)
	FileUtils.chown(node[:openstack][:user], node[:openstack][:user], tempfile)
	f = File.open("#{TEMPLATE_DIR}/_stylesheets.html", "r")
	f.each do |line|
	  tempfile<<line
	  if line.downcase =~ /horizon.less/
	    tempfile << "<link href='{{ STATIC_URL }}dashboard/css/custom.css' type='text/css' media='screen' rel='stylesheet' />\n"
	  end
	end
	f.close
	tempfile.close
	FileUtils.mv("_stylesheets.html", "#{TEMPLATE_DIR}/_stylesheets.html")
    end
  end

#Restart Apache server
service "apache2" do
  action :restart
end




