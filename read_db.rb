#!/usr/bin/ruby -rubygems
require 'active_record'
require 'net/https'
require 'json'
require 'uri'

require 'lib'

User.all.each do |user|

  p user.id

end
