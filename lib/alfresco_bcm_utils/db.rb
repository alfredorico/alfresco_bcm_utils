ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => File.expand_path("../../../config/db.sqlite3", __FILE__)
)
