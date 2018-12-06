require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/book")
require("./lib/author")
require("./lib/patron")
require("pg")

DB = PG.connect({:dbname => "library"})

get("/") do
  @book_list = Book.all()
  @authors_list = Author.all()
  erb(:index)
end

get("/authors") do
  @authors = Author.all()
  erb(:add_author)
end

get("/books") do
  @books = Book.all()
  erb(:add_book)
end

post("/authors") do
  name = params.fetch("name")
  author = Author.new({:name => name, :id => nil})
  author.save()
  @author = Author.all()
  erb(:author)
end

post("/books") do
  title = params.fetch("title")
  book = Book.new({:title => title, :id => nil})
  book.save()
  @books = Book.all()
  erb(:books)
end

get("/authors/:id") do
  @author = Author.find(params.fetch("id").to_i())
  @books = Book.all()
  erb(:author_info)
end

get("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @authors = Author.all()
  erb(:book_info)
end

patch("/authors/:id") do
  author_id = params.fetch("id").to_i()
  @author = Author.find(author_id)
  book_ids = params.fetch("book_ids")
  @author.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:author_info)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find(book_id)
  author_ids = params.fetch("author_ids")
  @book.update({:author_ids => author_ids})
  @authors = Author.all()
  erb(:book_info)
end

get("/add_book") do
  erb(:add_book)
end

post("/add_book") do
  title = params.fetch("title")
  new_book = Book.new({:title => title, :id => nil})
  new_book.save()
  name = params.fetch("author")
  new_author = Author.new({:name => name, :id => nil})
  new_author.save()
  redirect('/')
end

# post("/book_list/titles") do
#   @book_list = Book.sort_by_title
#   erb(:book_list)
# end
#
# post("/book_list/authors") do
#   @book_list = Book.sort_by_author
#   erb(:book_list)
# end
#
# get("/book_list") do
#   @book_list = Book.all()
#
#   erb(:book_list)
# end
#
# get("/checkout/:title") do
#   title = params[:title]
#
#   @book = Book.find_by_title(title)
#   erb(:checkout)
# end
#
# get("/book_search_title") do
#   title = params.fetch('title')
#   @book = Book.find_by_title(title)
#   erb(:book)
# end
#
# get("/book_search_author") do
#   author = params.fetch('author')
#   @book = Book.find_by_author(author)
#   erb(:book)
# end
#
# get("/book/:id") do

#   @book = Book.all()
#   erb(:book)
# end
