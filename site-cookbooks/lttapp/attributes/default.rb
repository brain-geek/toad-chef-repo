default[:application_path] = "/var/www/ltt"
default[:application_repo] = "git://github.com/brain-geek/load_test_target_app.git"

default[:application_env] = "production"

default[:workers_count] = 1

override['rvm']['user_installs'] = [ { :user => "brain" } ]
override['rvm']['user_rubies'] = [ "1.9.3" ]

override['rvm']['version'] =          "1.17.10"
override['rvm']['installer_url'] =    "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
override['rvm']['branch'] =           "none"
