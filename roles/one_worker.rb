name "one_worker"
description "Target app with one worker"

override_attributes :workers_count => 1

run_list(
  "recipe[lttapp]"
  )