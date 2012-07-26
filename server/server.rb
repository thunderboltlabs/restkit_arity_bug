#!/usr/bin/env bundle exec shotgun -p 4567
# require 'bundler'
Bundler.require

enable :logging

get '/coffee_shops' do
  puts "Got request..."
  json({
         coffee_shops: [
           {
             id:         1,
             latitude:   "20.0",
             longitude:  "-122.4075",
             name:       "Foo",
             shot_count: 0
           }
         ]
       })
end

