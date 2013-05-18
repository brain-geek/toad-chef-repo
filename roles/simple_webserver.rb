name "simple_webserver"
description "Simple webserver to use with load test target application"

run_list(
  "recipe[nginx::default]"
  # ,"recipe[nginx::passenger]"
  )