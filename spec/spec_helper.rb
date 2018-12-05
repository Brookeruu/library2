require("rspec")
require("pg")
require("book")

DB = PG.connect({:dbname => "library"})

RSpec.configure do |config|
  config.after(:each) do
  DB.exec("DELETE FROM book *;")
  end
end
