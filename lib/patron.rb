require 'pg'
require 'pry'

class Patron
  attr_reader(:name, :id, :checkout, :history)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @checkout = attributes.fetch(:checkout)
    @history = attributes.fetch(:history)
  end

  def save
    patron_list = DB.exec("INSERT INTO patron (name, checkout, history) VALUES ('#{@name}', '#{@checkout}', '#{@history}') RETURNING id;")
    @id = patron_list.first().fetch("id").to_i()
  end

  def self.all
    patron_list = DB.exec("SELECT * FROM patron;")
    patrons = []
    patron_list.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      checkout = patron.fetch("checkout")
      history = patron.fetch("history")
      patrons.push(Patron.new({:name => name, :id => id, :checkout => checkout, :history => history}))
    end
    patrons
  end

  def ==(another_patron)
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id())).&(self.checkout().==(another_patron.checkout())).&(self.history().==(another_patron.history()))
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patron WHERE id = #{id};").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i
    history = patron.fetch("history")
    checkout = patron.fetch("checkout")

    patron_id = Patron.new({:name => name, :id => id, :checkout => checkout, :history => history})
    patron_id
  end

  def self.find_by_name(name)
    book = DB.exec("SELECT * FROM book WHERE name = '#{name}';").first
    name = book.fetch("name")
    id = book.fetch("id").to_i
    history = book.fetch("history")
    checkout = book.fetch("checkout")

    patron_id = Patron.new({:name => name, :id => id, :checkout => checkout, :history => history})
    patron_id
  end

end
