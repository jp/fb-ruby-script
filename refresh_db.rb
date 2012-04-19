#!/usr/bin/ruby -rubygems
require 'lib'


############ get app token ################
path = "/oauth/access_token?client_id=#{APP_ID}&client_secret=#{APP_SECRET}&grant_type=client_credentials"
APP_ACCESS_TOKEN = get(path)


users_path = URI.escape("/#{APP_ID}/accounts/test-users?#{APP_ACCESS_TOKEN}&limit=500")
users = JSON.parse(get(users_path))

users["data"].each do |u|
  db_user = User.find_by_fb_id(u["id"])
  if db_user
    db_user.access_token = u["access_token"]
    db_user.save
  end
end

