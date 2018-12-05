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


  describe('.sort_by_author') do
    it('Sorts books by author') do
      test_book1 = Book.new({:title => "title", :author => "Bill", :id => 1, :duedate => "2018-12-25", :checkout => "t"})
      test_book1.save()

      test_book2 = Book.new({:title => "title (2)", :author => "Augustus", :id => 2, :duedate => "2018-12-25", :checkout => "t"})
      test_book2.save()

      test_book3 = Book.new({:title => "title-3", :author => "Lara", :id => 3, :duedate => "2018-12-25", :checkout => "t"})
      test_book3.save()

      test_book4 = Book.new({:title => "title (4)", :author => "Candice", :id => 4, :duedate => "2018-12-25", :checkout => "t"})
      test_book4.save()

      expect(Book.sort_by_author()).to(eq([test_book2, test_book1, test_book4, test_book3]))

    end
  end

  describe('#find_by_author') do
    it("Finds a book based on its author") do

      test_book1 = Book.new({:title => "title", :author => "Steve", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
      test_book1.save()

      test_book2 = Book.new({:title => "title (2)", :author => "Francine", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
      test_book2.save()


      test_author = test_book2.author
      testing = Book.find_by_author(test_author)

      expect(testing).to(eq(test_book2))
    end
  end

  describe('#find_by_title') do
    it("Finds a book based on its title") do

      test_book1 = Book.new({:title => "One of the Harry Potters", :author => "Steve", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
      test_book1.save()

      test_book2 = Book.new({:title => "Sword of Truth", :author => "Francine", :id => nil, :duedate => "2018-12-25", :checkout => "t"})
      test_book2.save()


      test_title = test_book2.title
      testing = Book.find_by_title(test_title)

      expect(testing).to(eq(test_book2))
    end
  end


end
