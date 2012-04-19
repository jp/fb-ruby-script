require 'fb_secret'

require 'active_record'
require 'net/https'
require 'json'
require 'uri'

############ create sqlite db in memory ################

DB_FILE = "fb_test_users.sqlite"

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => DB_FILE
)

if !File.exists?(DB_FILE)
  ActiveRecord::Schema.define do
      create_table :users do |table|
          table.column :fb_id, :string
          table.column :access_token, :string
          table.column :login_url, :string
          table.column :email, :string
          table.column :password, :string
      end

  end
end

############ active record declarations ################

class User < ActiveRecord::Base
  has_many :users
end

############ define methods ################

def get(path)
  uri = URI.parse("https://graph.facebook.com"+path)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  return http.request(request).body
end


