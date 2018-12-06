require('rspec')
require('pg')
require('book')
require('spec_helper')

describe(Book) do

  describe('#save') do
    it("Saves book to database") do
      test_book = Book.new({:title => "title", :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('.all') do
    it('returns all books in library') do
      test_book = Book.new({:title => "title", :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#find') do
    it("Finds a book based on its ID") do

      test_book1 = Book.new({:title => "title", :id => nil})
      test_book1.save()

      test_book2 = Book.new({:title => "title (2)", :id => nil})
      test_book2.save()

      test_id = test_book2.id
      testing = Book.find(test_id)

      expect(testing).to(eq(test_book2))
    end
  end

  #
  # describe('.sort_by_author') do
  #   it('Sorts books by author') do
  #     test_book1 = Book.new({:title => "title", :author => "Bill", :id => 1, :duedate => "2018-12-25", :checkout => "t"})
  #     test_book1.save()
  #
  #     test_book2 = Book.new({:title => "title (2)", :author => "Augustus", :id => 2, :duedate => "2018-12-25", :checkout => "t"})
  #     test_book2.save()
  #
  #     test_book3 = Book.new({:title => "title-3", :author => "Lara", :id => 3, :duedate => "2018-12-25", :checkout => "t"})
  #     test_book3.save()
  #
  #     test_book4 = Book.new({:title => "title (4)", :author => "Candice", :id => 4, :duedate => "2018-12-25", :checkout => "t"})
  #     test_book4.save()
  #
  #     expect(Book.sort_by_author()).to(eq([test_book2, test_book1, test_book4, test_book3]))
  #
  #   end
  # end

  # describe('#find_by_author') do
  #   it("Finds a book based on its author") do
  #
  #     test_book1 = Book.new({:title => "title", :author => "Steve", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
  #     test_book1.save()
  #
  #     test_book2 = Book.new({:title => "title (2)", :author => "Francine", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
  #     test_book2.save()
  #
  #
  #     test_author = test_book2.author
  #     testing = Book.find_by_author(test_author)
  #
  #     expect(testing).to(eq(test_book2))
  #   end
  # end

  describe('#find_by_title') do
    it("Finds a book based on its title") do

      test_book1 = Book.new({:title => "One of the Harry Potters", :id => nil})
      test_book1.save()

      test_book2 = Book.new({:title => "Sword of Truth", :id => nil})
      test_book2.save()

      test_title = test_book2.title
      testing = Book.find_by_title(test_title)

      expect(testing).to(eq(test_book2))
    end
  end

  describe("#==") do
    it("is the same book if it has the same name and id") do
      book = Book.new({:title => "Oceans Eleven", :id => nil})
      book2 = Book.new({:title => "Oceans Eleven", :id => nil})
      expect(book).to(eq(book2))
    end
  end

  describe("#update") do
    it("lets you update book in the database") do
      book = Book.new({:title => "Oceans Eleven", :id => nil})
      book.save()
      book.update({:title => "Oceans Twelve"})
      expect(book.title()).to(eq("Oceans Twelve"))
    end
  end

  describe("#delete") do
    it("lets you delete a book from the database") do
      book = Book.new({:title => "Oceans Eleven", :id => nil})
      book.save()
      book2 = Book.new({:title => "Oceans Twelve", :id => nil})
      book2.save()
      book.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end


end
