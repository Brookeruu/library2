require 'pg'
require 'pry'

class Book
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
    # @duedate = attributes.fetch(:duedate)
    # @checkout = attributes.fetch(:checkout)
  end

  def save
    book_list = DB.exec("INSERT INTO book (title) VALUES ('#{@title}') RETURNING id;")
    @id = book_list.first().fetch("id").to_i()
  end

  def self.all
    book_list = DB.exec("SELECT * FROM book;")
    books = []
    book_list.each() do |book|
      title = book.fetch("title")
      id = book.fetch("id").to_i
      books.push(Book.new({:title => title, :id => id}))
    end
    books
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM book WHERE id = #{id};").first
    title = book.fetch("title")
    id = book.fetch("id").to_i

    readable_book = Book.new({:title => title, :id => id})
    readable_book
  end

  def self.find_by_author(author)
    book = DB.exec("SELECT * FROM book WHERE author = '#{author}';").first
    title = book.fetch("title")
    id = book.fetch("id").to_i
    readable_book = Book.new({:title => title, :id => id})
    readable_book
  end

  def self.find_by_title(title)
    book = DB.exec("SELECT * FROM book WHERE title = '#{title}';").first
    title = book.fetch("title")
    id = book.fetch("id").to_i
    readable_book = Book.new({:title => title, :id => id})
    readable_book
  end

  def self.find_by_duedate(author)

    book = DB.exec("SELECT * FROM book WHERE duedate = '#{duedate}';").first
    title = book.fetch("title")
    id = book.fetch("id").to_i
    due_book = Book.new({:title => title, :id => id})
    due_book
  end


    def self.sort_by_author
      book_list = DB.exec("SELECT * FROM book ORDER BY author;")
      books = []
      book_list.each() do |book|
        title = book.fetch("title")
        id = book.fetch("id").to_i

        books.push(Book.new({:title => title, :id => id}))
      end
      books
    end

    def self.sort_by_title
      book_list = DB.exec("SELECT * FROM book ORDER BY title;")
      books = []
      book_list.each() do |book|
      title = book.fetch("title")
      id = book.fetch("id").to_i

        books.push(Book.new({:title => title, :id => id}))
      end
      books
    end

  def ==(another_book)
    self.title().==(another_book.title()).&(self.id().==(another_book.id()))
  end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    @id = self.id()
    DB.exec("UPDATE book SET title = '#{@title}' WHERE id = #{@id};")

    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO author_book_join (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
    end
  end

  def delete
    DB.exec("DELETE FROM book WHERE id = #{self.id()};")
  end

  def authors
    book_authors = []
    authors = DB.exec("SELECT author_id FROM author_book_join WHERE book_id = #{self.id()};")
    authors.each() do |author|
      author_id = author.fetch("author_id").to_i()
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id}")
      name = author.first().fetch("name")
      book_authors.push(Author.new({:name => name, :id => author_id}))
    end
    book_authors
  end
end
