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

end
