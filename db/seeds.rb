require_relative('../models/author')
require_relative('../models/book')
require_relative('../models/bookauthor')
require_relative('../models/bookgenre')
require_relative('../models/genre')
require_relative('../models/wholesaler')

Author.delete_all()

author1 = {"first_name" => "Douglas", "last_name" => "Adams"}
author2 = {"first_name" => "John", "last_name" => "Lloyd"}

new_author1 = Author.new(author1)
new_author2 = Author.new(author2)

new_author1.save
new_author2.save

# new_author1.delete - Used to test delete instance function

p Author.find_by_id(new_author1.id)
