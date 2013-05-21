#
# Cookbook Name:: lttapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"
include_recipe "rvm::user"

template "#{node['nginx']['dir']}/sites-available/target_site" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "target_site", :enable => true
nginx_site "default", :enable => false

node.override['nginx']['default_site_enabled'] = false

# rvm_ruby "ree-1.8.7-2011.01" do
#   action :install
#   user 'brain'
# end

# rvm_default_ruby "ree-1.8.7-2011.01" do
#   user 'brain'
# end

application "lttapp" do
  action :force_deploy

  path node[:application_path]
  owner "brain"
  group "brain"

  repository "git://github.com/brain-geek/load_test_target_app.git"
  revision "master"

  before_restart do
    exclude_env_gems = ['development', 'test']

    # rvm_shell "install_gems" do
    #   user        "brain"
    #   group       "brain"
    #   cwd         "#{node[:application_path]}/current"
    #   code        %{bundle install --gemfile #{node[:application_path]}/current/Gemfile --path #{node[:application_path]}/shared/bundle --deployment --quiet --without #{exclude_env_gems.join(' ')}}
    # end
  end

  # migration_command "cd #{node[:application_path]}/current && rake prepare_data"
  # restart_command  "cd #{node[:application_path]}/current && bundle exec unicorn_rails -D -c /etc/unicorn/lttapp.rb"

  # Apply the rails LWRP from application_ruby
  rails do
    database_template "database_sqlite.yml.erb"
    bundler false
  end

  unicorn do
    port node[:unicorn_port]
  end 
end