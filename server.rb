require 'sinatra'
require 'pry'
require 'sinatra/reloader'

def get_file
  file = File.("list.txt","a+")
end


get '/groceries' do


  index :erb
end
