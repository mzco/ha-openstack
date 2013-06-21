default[:openstack][:user] = "mzc"
default[:openstack][:group] = "mzc"

default[:horizon_dashboard_dir][:dev_stack] = '/opt/stack/horizon/openstack_dashboard/static/dashboard'  
default[:horizon_template_dir][:dev_stack] = '/opt/stack/horizon/openstack_dashboard/templates' 

default[:horizon_dashboard_dir][:ubuntu] = '/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard'  
default[:horizon_template_dir][:ubuntu] = '/usr/share/pyshared/openstack_dashboard/templates' 



