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

package :git do
  action :install
end

application "lttapp" do
  action :deploy

  path node[:application_path]
  owner "brain"
  group "brain"

  repository "git://github.com/brain-geek/load_test_target_app.git"
  revision "master"

  restart_command "cd #{node[:application_path]}/current && bundle exec rake unicorn:stop prepare_data ; sleep 3 && bundle exec rake unicorn:start"

  rails do
    database_template "database_sqlite.yml.erb"
    bundler true
    bundler_deployment true

    precompile_assets true
  end

  before_migrate do
    Chef::Log.info "Linking tmp"
    directory "#{new_resource.path}/shared/tmp" do
      owner new_resource.owner
      group new_resource.group
      mode '0755'
    end

    execute "rm -rf tmp" do
      cwd new_resource.release_path
      user new_resource.owner
      environment new_resource.environment
    end

    link "#{new_resource.release_path}/tmp" do
      to "#{new_resource.path}/shared/tmp"
    end  
  end
end