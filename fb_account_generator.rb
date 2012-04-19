#!/usr/bin/ruby -rubygems
require 'active_record'
require 'net/https'
require 'json'
require 'uri'

require 'lib'

NB_USERS_TO_CREATE = 5


############ create users ################



i = 0
while i < NB_USERS_TO_CREATE
  username = `rig | head -n 1`
  path = "/#{APP_ID}/accounts/test-users?
    installed=true
    &name=#{username}
    &locale=en_US
    &permissions=read_stream
    &method=post
    &#{APP_ACCESS_TOKEN}"
  puts path

  fbu = JSON.parse(get(path))

  p fbu.to_s

  User.create(
    :fb_id => fbu["id"],
    :access_token => fbu["access_token"],
    :login_url => fbu["login_url"],
    :email => fbu["email"],
    :password => fbu["password"]
  )

  i+=1
end
