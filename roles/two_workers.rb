name "two_workers"
description "Target app with two workers"

override_attributes :workers_count => 2

run_list(
  "recipe[lttapp]"
  )