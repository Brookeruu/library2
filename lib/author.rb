require 'pg'
require 'pry'

class Author
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    author_list = DB.exec("SELECT * FROM authors;")
    authors = []
    author_list.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  def self.find(id)
    author_id = DB.exec("SELECT * FROM authors WHERE id = #{id};")
    name = author_id.first().fetch("name")
    Author.new({:name => name, :id => id})
  end

  def save
    author_list = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = author_list.first().fetch("id").to_i
  end

  def ==(another_author)
    self.name().==(another_author.name()).&(self.id().==(another_author.id()))
  end

  def update(attributes)
    # Notice the lines @name = attributes.fetch(:name, @name) and attributes.fetch(:actor_ids, []). In both we are passing in a second argument to the fetch method.

     # **This provides a default value so if either :name or :actor_ids don't exist, it will return the default value instead of raising the key not found error.**
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO author_book_join (author_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end

  def books
    author_books = []
    books = DB.exec("SELECT book_id FROM author_book_join WHERE author_id = #{self.id()};")
    books.each() do |book|
      book_id = book.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM book WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author_books.push(Book.new({:title => title, :id => book_id}))
    end
    author_books
  end


  def delete
    DB.exec("DELETE FROM author_book_join WHERE author_id = #{self.id()};")
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
  end




end
