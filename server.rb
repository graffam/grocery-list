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

def write_to_file (item)
  File.open(get_file,"a") do |f|
    f.write("#{item}\n")
  end
end


get '/groceries' do
  file = get_file
  @contents = read_file(file)
  erb :index
end

post '/groceries' do
  write_to_file(params[:Item])
  redirect '/groceries'
end
