# Start all servers on local
foreman start -f Procfile.dev

# Generating a channel to broadcast
rails g channel message

# Heroku setup
## Heroku requires extra pipeline (limitation of heroku)
heroku create ws-demo-app

heroku pipelines:add ws-demo-app-pipeline -a ws-demo-app

heroku create ws-demo-app-anycable --remote anycable

heroku pipelines:add ws-demo-pipeline -a ws-demo-app-anycable

heroku addons:create heroku-postgresql

heroku addons:create heroku-redis

heroku buildpacks:add heroku/ruby -a ws-demo-app-anycable

references from:

https://docs.anycable.io/deployment/heroku


# Get all add-ons from main app

heroku addons -a ws-demo-app

# Share the db and redis

heroku addons:attach postgresql-aerodynamic-23089 -a ws-demo-app-anycable

heroku addons:attach redis-rigid-76092 -a ws-demo-app-anycable


# Configure the environment variable for anycable heroku

heroku config:set ANYCABLE_DEPLOYMENT=true -a ws-demo-app-anycable

heroku config:set ANYCABLE_HOST=0.0.0.0 -a ws-demo-app-anycable

heroku config:set RAILS_ENV=production -a ws-demo-app-anycable

# Set the main app to connect to anycable heroku

heroku config:set CABLE_URL="wss://ws-demo-app-anycable.herokuapp.com/cable" -a ws-demo-app



