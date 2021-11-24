require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
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

  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue"
    # FILL IN HERE
    puts overdue.to_displayable_list
    puts "\n\n"

    puts "Due Today"
    # FILL IN HERE
    puts due_today.to_displayable_list
    puts "\n\n"

    puts "Due Later"
    # FILL IN HERE
    puts due_later.to_displayable_list
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
