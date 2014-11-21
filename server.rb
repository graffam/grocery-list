require 'sinatra'
require 'pry'
require 'sinatra/reloader'

def get_file
  file = File.open("list.txt","a+")
end

def read_file (file)
  read_file = File.read(file)
  read_file.split("\n")
end


get '/groceries' do
  file = get_file
  @contents = read_file(file)
  binding.pry
  erb :index
end
