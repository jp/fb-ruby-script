#!/usr/bin/ruby -rubygems
require 'lib'

User.all.each do |user|

  if user.fb_id == nil
    user.destroy
  end
  puts user.fb_id + "," + user.access_token

end

# puts User.all.length.to_s + " users"
