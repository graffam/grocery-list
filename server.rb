require 'sinatra'
require 'pry'
require 'sinatra/reloader'
require 'pg'

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

def connect
  conn = PG::Connection.new( :dbname => 'grocery', :port => 5432 )
end

def items
  list = []
  conn = connect
  conn.exec("SELECT * FROM items") do |result|
    list << result
  end
  binding.pry
end


get '/groceries' do
  # items
  file = get_file
  @contents = read_file(file)
  erb :index
end

post '/groceries' do
  write_to_file(params[:Item])
  redirect '/groceries'
end

post '/grocies/delete' do
binding.pry
end
