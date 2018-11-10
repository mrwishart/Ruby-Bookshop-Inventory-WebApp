require_relative('../models/author')
require_relative('../models/book')
require_relative('../models/bookauthor')
require_relative('../models/bookgenre')
require_relative('../models/genre')
require_relative('../models/wholesaler')

author1 = {"first_name" => "Douglas", "last_name" => "Adams"}

new_author1 = Author.new(author1)

new_author1.save
