require 'pg'
require 'pry'

class Book
  attr_reader(:title, :author, :id, :duedate, :checkout)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
    @duedate = attributes.fetch(:duedate)
    @checkout = attributes.fetch(:checkout)
  end

  def save
    book_list = DB.exec("INSERT INTO book (title, author, duedate, checkout) VALUES ('#{@title}', '#{@author}', '#{@duedate}', '#{@checkout}') RETURNING id;")
    @id = book_list.first().fetch("id").to_i()
  end

  def self.all
    book_list = DB.exec("SELECT * FROM book;")
    books = []
    book_list.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      id = book.fetch("id").to_i
      duedate = book.fetch("duedate")
      checkout = book.fetch("checkout")
      books.push(Book.new({:title => title, :author => author, :id => id, :duedate => duedate, :checkout => checkout}))
    end
    books
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM book WHERE id = #{id};").first
    title = book.fetch("title")
    author = book.fetch("author")
    id = book.fetch("id").to_i
    duedate = book.fetch("duedate")
    checkout = book.fetch("checkout")

    readable_book = Book.new({:title => title, :author => author, :id => id, :duedate => duedate, :checkout => checkout})
    readable_book
  end

  def self.find_by_author(author)
    book = DB.exec("SELECT * FROM book WHERE author = '#{author}';").first
    title = book.fetch("title")
    author = book.fetch("author")
    id = book.fetch("id").to_i
    duedate = book.fetch("duedate")
    checkout = book.fetch("checkout")

    readable_book = Book.new({:title => title, :author => author, :id => id, :duedate => duedate, :checkout => checkout})
    readable_book
  end

  def self.find_by_title(title)
    book = DB.exec("SELECT * FROM book WHERE title = '#{title}';").first
    title = book.fetch("title")
    author = book.fetch("author")
    id = book.fetch("id").to_i
    duedate = book.fetch("duedate")
    checkout = book.fetch("checkout")

    readable_book = Book.new({:title => title, :author => author, :id => id, :duedate => duedate, :checkout => checkout})
    readable_book
  end


    def self.sort_by_author
      book_list = DB.exec("SELECT * FROM book ORDER BY author;")
      books = []
      book_list.each() do |book|
        title = book.fetch("title")
        author = book.fetch("author")
        id = book.fetch("id").to_i
        duedate = book.fetch("duedate")
        checkout = book.fetch("checkout")
        books.push(Book.new({:title => title, :author => author, :id => id, :duedate => duedate, :checkout => checkout}))
      end
      books
    end

    def self.sort_by_title
      book_list = DB.exec("SELECT * FROM book ORDER BY title;")
      books = []
      book_list.each() do |book|
        title = book.fetch("title")
        author = book.fetch("author")
        id = book.fetch("id").to_i
        duedate = book.fetch("duedate")
        checkout = book.fetch("checkout")
        books.push(Book.new({:title => title, :author => author, :id => id, :duedate => duedate, :checkout => checkout}))
      end
      books
    end

  def ==(another_book)
    self.title().==(another_book.title()).&(self.author().==(another_book.author())).&(self.id().==(another_book.id())).&(self.duedate().==(another_book.duedate())).&(self.checkout().==(another_book.checkout()))
  end



end
