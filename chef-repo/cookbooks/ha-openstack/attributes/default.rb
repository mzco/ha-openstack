default[:openstack][:user] = "mzc"
default[:openstack][:group] = "mzc"

default[:horizon_dashboard_dir][:dev_stack] = '/opt/stack/horizon/openstack_dashboard/static/dashboard'  
default[:horizon_template_dir][:dev_stack] = '/opt/stack/horizon/openstack_dashboard/templates' 

default[:horizon_dashboard_dir][:ubuntu] = '/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard'  
default[:horizon_template_dir][:ubuntu] = '/usr/share/pyshared/openstack_dashboard/templates' 

default['haproxy']['balance_algorithm'] = "roundrobin"
default['haproxy']['enable_admin'] = true
default['haproxy']['admin']['address_bind'] = "10.21.245.21"
default['haproxy']['admin']['port'] = 22002
default['haproxy']['pid_file'] = "/var/run/haproxy.pid"
default['haproxy']['cfg_file'] = "/etc/haproxy/haproxy.cfg" 

default['haproxy']['user'] = "haproxy"
default['haproxy']['group'] = "haproxy"

default['haproxy']['member_max_connections'] = 100



