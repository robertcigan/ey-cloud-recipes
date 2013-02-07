if ['app_master', 'app', 'solo'].include?(node[:instance_role])
  # service
  service "nginx" do
    supports :reload => true
  end
  
  # stack.conf
  template "/etc/nginx/stack.conf" do
    source 'stack.conf.erb'
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    backup false
    variables({
      :user => node[:owner_name],
      :passenger_spawn_method => node[:passenger_spawn_method],
      :passenger_max_pool_size => node[:passenger_max_pool_size],
      :passenger_max_instances_per_app => node[:passenger_max_instances_per_app],
      :passenger_pool_idle_time => node[:passenger_pool_idle_time]
    })
    notifies :reload, resources(:service => :nginx), :delayed
  end
end

node["engineyard"]["environment"]["apps"].each do |app|
  template "/data/nginx/servers/#{app["name"]}.conf" do
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    source "nginx_app.conf.erb"
    variables({
      :domain_name => app["vhosts"].first["domain_name"],
      :name => app["name"],
      :app_type => app['type'] == 'rails' ? 'rails' : 'rack', 
      :port => 80,
      :framework_env => node["environment"]["framework_env"],
      :passenger_min_instances => node[:passenger_min_instances]
    })
    notifies :reload, resources(:service => :nginx), :delayed
  end
end

