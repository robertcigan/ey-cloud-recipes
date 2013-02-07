#
# Cookbook Name:: passenger_monitor
# Recipe:: default
#
#Edit the current passenger monitor to prevent the upstream errors

template "/engineyard/bin/passenger_monitor" do
    owner 'root'
    group 'root'
    mode 0755
    source "passenger_monitor.erb"
  end