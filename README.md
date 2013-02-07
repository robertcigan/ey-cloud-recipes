Installation
============

Follow these steps to use custom deployment recipes with your applications.

* Install the engineyard gem:
  $ gem install engineyard
* Add any custom recipes or tweaks to your copy of these recipes (inspect each recipes)
* Upload and enable them with: `ey recipes upload -e ENV`, where ENV is the name of your environment in Engine Yard Cloud. This may be different than your Rails environment name.
* Once you have completed these steps, each rebuild will run the your
  recipes after the default Engine Yard recipes have run. When you
  update your recipes, just re-run `ey recipes upload -e ENV`.

List of custom recipes follow. To enable/disable uncomment/comment a line in `cookbooks/main/recipes/default.rb`

passenger-monitor-memory-limit
===================================================================
EngineYard monitors automatically your passenger instances and terminates them if a limit 250MB by default is exceeded. 
If your app uses more for whatever reason you might want to increase that limit, otherwire you will receive a lot of SIGABRT errors in you box. 

Use the passenger_monitor_memory_limit cookbook or copy & include it to your chef recipes (add `require_recipe "passenger_monitor_memory_limit"` into your main recipe/default.rb).
Works for multiapp environment as well as for single app environment.
By default there's a 400MB limit. Change it to desired value in recipes/default.rb .

custom-stack-conf
=================

A custom chef recipe that allows you to customize various resource settings of Passenger workers on EY Cloud.

Update and of following resource controls inside of `attributes/default.rb`

`passenger_spawn_method`
`passenger_max_pool_size`
`passenger_max_instances_per_app`
`passenger_pool_idle_time`
`passenger_min_instances`

This will work ONLY for Rails 3 stack!!!

passenger_killer
================
Default EY Passenger monitor split into 2 parts - this one kill -9 all instances listed in `ps` but not listed in `passenger status` - generally orphan processes.

passenger_monitor
=================
Default EY Passenger monitor split into 2 parts - this one kill with USR signal (let the process to finish the request) when it reaches the memory limit (by default 250)
