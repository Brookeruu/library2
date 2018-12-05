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

get("/add_book") do
  erb(:add_book)
end

post("/add_book") do
  title = params.fetch("title")
  author = params.fetch("author")
  new_book = Book.new({:title => title, :author => author, :id => nil, :duedate => "2018-10-10", :checkout => "f"})
  new_book.save()
  redirect("/book_list")
end


post("/book_list/titles") do
  @book_list = Book.sort_by_title
  erb(:book_list)
end

post("/book_list/authors") do
  @book_list = Book.sort_by_author
  erb(:book_list)
end

get("/book_list") do
  @book_list = Book.all()
  erb(:book_list)
end

get("/checkout/:title") do
  title = params[:title]
  
  @book = Book.find_by_title(title)
  erb(:checkout)
end

get("/book_search_title") do
  title = params.fetch('title')
  @book = Book.find_by_title(title)
  erb(:book)
end

get("/book_search_author") do
  author = params.fetch('author')
  @book = Book.find_by_author(author)
  erb(:book)
end

get("/book/:id") do
  id = params[:id].to_i
  @book = Book.find(id)
  erb(:book)
end
