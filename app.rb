require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/book")
require("./lib/patron")
require("pg")

DB = PG.connect({:dbname => "library"})

get("/") do
  erb(:index)
end

post("/add_book") do
  title = params.fetch("title")
  author = params.fetch("author")
  duedate = params.fetch("duedate")
  checkout = params.fetch("checkout")

  new_book = Book.new({:title => title, :author => author, :duedate => duedate, :checkout => checkout})
  erb(:book_list)
end

get("/book_list") do
  @book_list = Book.all()
  erb(:book_list)
end

get("/book/:id") do
  id = params[:id].to_i
  @book = Book.find(id)
  erb(:book)
end
