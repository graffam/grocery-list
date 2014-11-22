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
  conn = connect
  results = conn.exec('SELECT item FROM items').to_a

end


get '/groceries' do
  @results = items
  erb :index
end

post '/groceries' do
  write_to_file(params[:Item])
  redirect '/groceries'
end

post '/grocies/delete' do
binding.pry
end
