require('rspec')
require('pg')
require('patron')
require('spec_helper')

describe(Patron) do

    describe("#initialize") do
      it("is initialized with a name") do
        patron = Patron.new({:name => "Brad Pitt", :id => nil})
        expect(patron).to(be_an_instance_of(Patron))
      end

    it("can be initialized with its database ID") do
      patron = Patron.new({:name => "Brad Pitt", :id => 1})
      expect(patron).to(be_an_instance_of(Patron))
    end
  end

  describe('#save') do
    it("Saves patron to database") do
      test_patron = Patron.new({:name => "name", :id => 1, :checkout => "t", :history => "none"})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe(".all") do
    it("starts off with no patrons") do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a patron by its ID number") do
      test_patron = Patron.new({:name => "Brad Pitt", :id => nil})
      test_patron.save()
      test_patron2 = Patron.new({:name => "George Clooney", :id => nil})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end
  end

  describe("#==") do
    it("is the same patron if it has the same name and id") do
      patron = Patron.new({:name => "Brad Pitt", :id => nil})
      patron2 = Patron.new({:name => "Brad Pitt", :id => nil})
      expect(patron).to(eq(patron2))
    end
  end

  describe("#update") do
    it("lets you update patrons in the database") do
      patron = Patron.new({:name => "George Clooney", :id => nil})
      patron.save()
      patron.update({:name => "Brad Pitt"})
      expect(patron.name()).to(eq("Brad Pitt"))
    end
  end

  describe("#checkout") do
    it("returns all of the books a patron has checked out") do
      book = Book.new({:title => "Oceans Eleven", :id => nil})
      book.save()
      book2 = Book.new({:title => "Oceans Twelve", :id => nil})
      book2.save()
      patron = Patron.new({:name => "George Clooney", :id => nil})
      patron.save()
      patron.update(:book_ids => [book.id()])
      patron.update(:book_ids => [book2.id()])
      binding.pry
      expect(patron.checkout()).to(eq([book, book2]))
    end
  end

end
