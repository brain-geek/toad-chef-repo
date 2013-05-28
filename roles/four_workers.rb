name "four_workers"
description "Target app with 4 workers"

override_attributes :workers_count => 4

run_list(
  "recipe[lttapp]"
  )