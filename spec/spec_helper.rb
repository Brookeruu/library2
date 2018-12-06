require("rspec")
require("pg")
require("book")
require("patron")
require("author")


DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
  DB.exec("DELETE FROM book *;")
  DB.exec("DELETE FROM patron *;")
  DB.exec("DELETE FROM authors *;")
  end
end
