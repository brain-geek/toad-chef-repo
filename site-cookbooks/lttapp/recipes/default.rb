#
# Cookbook Name:: lttapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.override['nginx']['default_site_enabled'] = false

include_recipe "nginx"

template "#{node['nginx']['dir']}/sites-available/target_site" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "target_site", :enable => true, :notifies => :immediately

%w{ git build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev
sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison ssl-cert pkg-config libgdbm-dev libffi-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

application "lttapp" do
  action :force_deploy

  path node[:application_path]
  owner "brain"
  group "brain"

  repository node[:application_repo]
  revision "master"

  environment "WORKERS_COUNT" => node[:workers_count].to_s, "RAILS_ENV" => node[:application_env]

  restart_command "cd #{node[:application_path]}/current && bundle exec rake unicorn:stop prepare_data ; sleep 3 && bundle exec rake unicorn:restart"

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

    link "#{new_resource.release_path}/tmp" do
      to "#{new_resource.path}/shared/tmp"
    end  
  end
end