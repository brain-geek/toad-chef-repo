#
# Cookbook Name:: lttapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe('nginx')

template "#{node['nginx']['dir']}/sites-available/target_site" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "target_site", :enable => true
nginx_site "default", :enable => false

node.override['nginx']['default_site_enabled'] = false