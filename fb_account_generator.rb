#!/usr/bin/ruby -rubygems
require 'lib'

NB_USERS_TO_CREATE = 500



############ get app token ################
path = "/oauth/access_token?client_id=#{APP_ID}&client_secret=#{APP_SECRET}&grant_type=client_credentials"
APP_ACCESS_TOKEN = get(path)


############ create users ################



i = 0
while i < NB_USERS_TO_CREATE
  username = `rig | head -n 1`.gsub("\n",'')
  path = URI.escape("/#{APP_ID}/accounts/test-users?installed=true&name=#{username}&locale=en_US&permissions=read_stream&method=post&#{APP_ACCESS_TOKEN}")
  puts path

  fbu = JSON.parse(get(path))

  p fbu.to_s
  p " - - - - - - - - - - - "

  User.create(
    :fb_id => fbu["id"],
    :access_token => fbu["access_token"],
    :login_url => fbu["login_url"],
    :email => fbu["email"],
    :password => fbu["password"]
  )

  i+=1
end
