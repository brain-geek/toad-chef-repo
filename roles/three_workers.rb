name "three_workers"
description "Target app with 3 workers"

override_attributes :workers_count => 3

run_list(
  "recipe[lttapp]"
  )