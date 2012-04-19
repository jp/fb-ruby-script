#!/usr/bin/ruby -rubygems
require 'lib'

User.all.each do |user|

  if user.fb_id == nil
    user.destroy
  end
  p user.id
  p user.fb_id
  p user.access_token

end

puts User.all.length.to_s + " users"
