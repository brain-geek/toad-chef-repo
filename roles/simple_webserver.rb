name "simple_webserver"
description "Simple webserver to use with load test target application"

run_list(
  "recipe[lttapp]"
  )