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
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")

  end


  def delete
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
  end




end
