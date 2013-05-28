name "five_workers"
description "Target app with 5 workers"

override_attributes :workers_count => 5

run_list(
  "recipe[lttapp]"
  )