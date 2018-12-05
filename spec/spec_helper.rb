require("rspec")
require("pg")
require("book")
require("patron")


DB = PG.connect({:dbname => "library"})

RSpec.configure do |config|
  config.after(:each) do
  DB.exec("DELETE FROM book *;")
  DB.exec("DELETE FROM patron *;")
  end
end
