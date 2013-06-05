#
# Cookbook Name:: toad
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

%w{git qt4-qmake libqt4-core libqt4-dev libqt4-webkit xvfb qt4-dev-tools libicu48 siege dstat}.each do |name|
  package name do
    action :install
  end
end

git "/home/brain/toad" do
   repository "git://github.com/brain-geek/toad.git"
   action :sync

  user "brain"
  group "brain"
end

execute "build toad" do
  command "qmake&&make clean&&make"
  cwd "/home/brain/toad"

  user "brain"
  group "brain"
end