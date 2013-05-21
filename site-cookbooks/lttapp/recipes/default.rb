#
# Cookbook Name:: lttapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.override['nginx']['install_method'] = 'source'
node.override['nginx']['default_site_enabled'] = false

include_recipe "nginx"

template "#{node['nginx']['dir']}/sites-available/target_site" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "target_site", :enable => true, :notifies => :immediately

directory "#{node[:application_path]}/shared/tmp" do
  recursive true
end

application "lttapp" do
  action :force_deploy

  path node[:application_path]
  owner "brain"
  group "brain"

  repository "git://github.com/brain-geek/load_test_target_app.git"
  revision "master"

  symlinks 'tmp' => 'tmp'

  restart_command "cd #{node[:application_path]}/current && bundle exec rake unicorn:stop prepare_data ; sleep 3 && bundle exec rake unicorn:start"

  rails do
    database_template "database_sqlite.yml.erb"
    bundler true
    bundler_deployment true

    precompile_assets true
  end
end