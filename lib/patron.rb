require 'pg'
require 'pry'

class Patron
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def save
    patron_list = DB.exec("INSERT INTO patron (name) VALUES ('#{@name}') RETURNING id;")
    @id = patron_list.first().fetch("id").to_i()
  end

  def self.all
    patron_list = DB.exec("SELECT * FROM patron;")
    patrons = []
    patron_list.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  def ==(another_patron)
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patron WHERE id = #{id};").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i

    patron_id = Patron.new({:name => name, :id => id})
    patron_id
  end

  def self.find_by_name(name)
    book = DB.exec("SELECT * FROM book WHERE name = '#{name}';").first
    name = book.fetch("name")
    id = book.fetch("id").to_i

    patron_id = Patron.new({:name => name, :id => id})
    patron_id
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE patron SET name = '#{@name}' WHERE id = #{@id};")
    attributes.fetch(:book_ids, []).each() do |book_id|
    DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end


  def checkout
    checkouts = []
    books = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{self.id()};")
    books.each() do |book|
      book_id = book.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM book WHERE id = #{book_id}")
      title = book.first().fetch("title")
      # id = patron.first().fetch("id")
      checkouts.push(Book.new({:title => title, :id => book_id}))
    end
    checkouts
  end

  def delete
    DB.exec("DELETE FROM checkouts WHERE patron_id = #{self.id()};")
    DB.exec("DELETE FROM patron WHERE id = #{self.id()};")
  end




end
