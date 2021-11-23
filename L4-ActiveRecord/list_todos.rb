require "./connect_db.rb"
require "./todo.rb"
connect_db!

# Instance method
# displayable_list = Todo.all.map { |todo| todo.to_displayable_string }
# puts displayable_list
# Class Method
# puts Todo.to_displayable_list
# puts Todo.where(completed: true).to_displayable_list

Todo.show_list
