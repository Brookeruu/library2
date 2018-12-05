require('rspec')
require('pg')
require('book')
require('spec_helper')

describe(Book) do

  describe('#save') do
    it("Saves book to database") do
      test_book = Book.new({:title => "title", :author => "author", :id => 1, :duedate => "2018-12-25", :checkout => "t"})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('.all') do
    it('returns all books in library') do
      test_book = Book.new({:title => "title", :author => "author", :id => 1, :duedate => "2018-11-25", :checkout => "f"})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#find') do
    it("Finds a book based on its ID") do

      test_book1 = Book.new({:title => "title", :author => "author", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
      test_book1.save()

      test_book2 = Book.new({:title => "title (2)", :author => "author (2)", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
      test_book2.save()


      test_id = test_book2.id
      testing = Book.find(test_id)

      expect(testing).to(eq(test_book2))
    end
  end

  describe('.search_by_author')

end
