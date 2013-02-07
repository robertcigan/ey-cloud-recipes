#
# Cookbook Name:: passenger_killer
# Recipe:: default
#

template "/engineyard/bin/passenger_killer" do
    owner 'root'
    group 'root'
    mode 0755
    source "passenger_killer.erb"
  end
  
  cron "passenger_killer" do
    minute   '0'
    hour     '2'
    day      '*'
    month    '*'
    weekday  '*'
    command  "/engineyard/bin/passenger_killer"
  end