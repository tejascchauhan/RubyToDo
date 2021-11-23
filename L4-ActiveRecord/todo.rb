require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def overdue?
    due_date < Date.today
  end

  def due_later?
    due_date > Date.today
  end

  def to_displayable_string
    display_id = id
    display_status = completed ? "[x]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{display_id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue"
    # FILL IN HERE
    puts all.filter { |todo| todo.overdue? }.map { |todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Today"
    # FILL IN HERE
    puts all.filter { |todo| todo.due_today? }.map { |todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Later"
    # FILL IN HERE
    puts all.filter { |todo| todo.due_later? }.map { |todo| todo.to_displayable_string }
  end

  def self.add_task(todo)
    text = todo[:todo_text]
    date = Date.today + todo[:due_in_days].to_i
    create!(todo_text: text, due_date: date, completed: false)
  end

  def self.mark_as_complete(todo_id)
    todo = find_by(id: todo_id)
    todo.update(completed: true)
    return todo
  end
end
