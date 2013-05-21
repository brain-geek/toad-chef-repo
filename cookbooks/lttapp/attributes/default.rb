default[:application_path] = "/var/www/ltt"
default[:unicorn_port] = '8080'

override['rvm']['user_installs'] = [ { :user => "brain" } ]
override['rvm']['user_rubies'] = [ "1.9.3" ]

override['rvm']['version'] =          "1.17.10"
override['rvm']['installer_url'] =    "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
override['rvm']['branch'] =           "none"
