require('rspec')
require('pg')
require('patron')
require('spec_helper')

describe(Patron) do
  describe('#save') do
    it("Saves patron to database") do
      test_patron = Patron.new({:name => "name", :id => 1, :checkout => "t", :history => "none"})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end
end
