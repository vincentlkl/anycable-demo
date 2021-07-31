<!-- to start all servers on local -->
foreman start -f Procfile.dev

1. bundle exec rails g anycable:setup
2. setup config/cable


<!-- generating a channel to broadcast -->
rails g channel message


<!-- heroku setup -->
<!-- heroku requires extra pipeline -->
heroku create ws-demo-app
heroku pipelines:add ws-demo-app-pipeline -a ws-demo-app
heroku create ws-demo-app-anycable --remote anycable
heroku pipelines:add ws-demo-pipeline -a ws-demo-app-anycable


heroku addons:create heroku-postgresql
heroku addons:create heroku-redis

heroku buildpacks:add heroku/ruby -a ws-demo-app-anycable
# get all add-ons from main app
heroku addons -a ws-demo-app

# share the db and redis
heroku addons:attach postgresql-aerodynamic-23089 -a ws-demo-app-anycable
heroku addons:attach redis-rigid-76092 -a ws-demo-app-anycable

# configure the environment variable for anycable heroku
heroku config:set ANYCABLE_DEPLOYMENT=true -a ws-demo-app-anycable
heroku config:set ANYCABLE_HOST=0.0.0.0 -a ws-demo-app-anycable
heroku config:set RAILS_ENV=production -a ws-demo-app-anycable

# set the main app to connect to anycable heroku
heroku config:set CABLE_URL="wss://ws-demo-app-anycable.herokuapp.com/cable" -a ws-demo-app



heroku buildpacks:add https://github.com/anycable/heroku-anycable-go -a ws-demo-app-anycable




heroku repo:rebuild -a ws-demo-app
