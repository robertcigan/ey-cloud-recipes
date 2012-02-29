passenger-monitor-memory-limit cookbook recipe for ey-cloud-recipes
===============
EngineYard monitors automatically your passenger instances and terminates them if a limit 250MB by default is exceeded. 
If your app uses more for whatever reason you might want to increase that limit, otherwire you will receive a lot of SIGABRT errors in you box. 

Use the passenger_monitor_memory_limit cookbook or copy & include it to your chef recipes (add require_recipe "passenger_monitor_memory_limit" into your main recipe/default.rb).
Works for multiapp environment as well as for single app environment.
By default there's a 400MB limit. Change it to desired value in recipes/default.rb .

Installation
============

Follow these steps to use custom deployment recipes with your applications.

* Install the engineyard gem:
  $ gem install engineyard
* Add any custom recipes or tweaks to your copy of these recipes.
* Upload them with: `ey recipes upload -e ENV`, where ENV is the name of your environment in Engine Yard Cloud. This may be different than your Rails environment name.
* Once you have completed these steps, each rebuild will run the your
  recipes after the default Engine Yard recipes have run. When you
  update your recipes, just re-run `ey recipes upload -e ENV`.
