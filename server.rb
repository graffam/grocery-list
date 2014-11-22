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
  begin
    conn = connect
    results = conn.exec('SELECT item FROM items').to_a
  ensure
    conn.close
  end
end

def add_item (item)
    begin
      conn = connect
      item_added = item
      query = "INSERT INTO items (item) VALUES('#{item_added}')"
      conn.exec(query)
    ensure
      conn.close
    end
end

def delete_item (item)
  begin
    conn = connect
    item_delete = item
    query = "DELETE FROM items WHERE item = '#{item_delete}'"
    conn.exec(query)
  ensure
    conn.close
  end
end

get '/groceries' do
  @results = items
  erb :index
end

post '/groceries' do
  add_item(params[:Item])
  redirect '/groceries'
end

post '/groceries/delete' do
  binding.pry
  delete_item(params[:button])
  redirect'/groceries'
end
