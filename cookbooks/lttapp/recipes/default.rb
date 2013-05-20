#
# Cookbook Name:: lttapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"
include_recipe "runit"

template "#{node['nginx']['dir']}/sites-available/target_site" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "target_site", :enable => true
nginx_site "default", :enable => false

node.override['nginx']['default_site_enabled'] = false


%w{build-essential git ruby-dev libreadline6 libreadline6-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison imagemagick}.each do |pkg|
  package pkg do
    action :install
  end
end

application "lttapp" do
  action :force_deploy

  path node[:application_path]
  owner "brain"
  group "brain"

  repository "git://github.com/brain-geek/load_test_target_app.git"
  revision "master"

  migration_command "cd #{node[:application_path]}/current && rake prepare_data"
  restart_command  "cd #{node[:application_path]}/current && bundle exec unicorn_rails -D -c /etc/unicorn/lttapp.rb"

  # Apply the rails LWRP from application_ruby
  rails do
    database_template "database_sqlite.yml.erb"
    bundler true
  end

  unicorn do
    preload_app true
    port node[:unicorn_port]
  end 
end