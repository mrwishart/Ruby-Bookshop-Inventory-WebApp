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
author3 = {"first_name" => "John", "last_name" => "Wishart"}
author4 = {"first_name" => "Roger", "last_name" => "John"}

new_author1 = Author.new(author1)
new_author2 = Author.new(author2)
new_author3 = Author.new(author3)
new_author4 = Author.new(author4)

new_author1.save
new_author2.save
new_author3.save
new_author4.save

# new_author1.delete - Used to test delete instance function

# p Author.find_by_id(new_author1.id) - Used to test find_by_id class



binding.pry
nil
