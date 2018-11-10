require_relative('../models/author')
require_relative('../models/book')
require_relative('../models/bookauthor')
require_relative('../models/bookgenre')
require_relative('../models/genre')
require_relative('../models/wholesaler')
require('pry-byebug')

Author.delete_all()

author1 = {"first_name" => "douGLas", "last_name" => "aDAMS"}
author2 = {"first_name" => "John", "last_name" => "Lloyd"}

new_author1 = Author.new(author1)
new_author2 = Author.new(author2)

new_author1.save
new_author2.save

# new_author1.delete - Used to test delete instance function

# p Author.find_by_id(new_author1.id) - Used to test find_by_id class

# new_author2.first_name = "Jonathan"
# new_author2.update

binding.pry
nil
