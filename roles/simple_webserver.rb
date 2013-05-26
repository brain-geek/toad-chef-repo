name "simple_webserver"
description "Simple webserver to use with load test target application"

override_attributes :workers_count => 10

run_list(
  "recipe[lttapp]"
  )