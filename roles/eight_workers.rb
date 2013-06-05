name "eight_workers"
description "Target app with 8 workers"

override_attributes :workers_count => 8

run_list(
  "recipe[lttapp]"
  )