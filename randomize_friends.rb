#!/usr/bin/ruby -rubygems
require 'lib'

MIN_FRIENDS = 10
MAX_FRIENDS = 100

User.all.each do |user|

  if user.fb_id == nil
    user.destroy
  else

    puts "======= fb user id : " + user.fb_id + "======="
    puts "== " + user.login_url

    i = 0
    random_nb_friends = rand(MAX_FRIENDS)+MIN_FRIENDS
    while i < random_nb_friends

      random_friend = User.all.sample
      rfid = random_friend.fb_id
      rfat = random_friend.access_token

      friend_path = "/#{user.fb_id}/friends/#{rfid}?method=post&access_token=#{user.access_token}"
      puts friend_path
      get(friend_path)

      friend_path = "/#{rfid}/friends/#{user.fb_id}?method=post&access_token=#{rfat}"
      puts friend_path
      get(friend_path)

      i+=1
    end
  end
end

puts User.all.length.to_s + " users"





