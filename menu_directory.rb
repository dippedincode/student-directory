@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
  puts "Enter 1,2 or 9:"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit # this will stop the program
  else
    puts "I don't know what you meant, please try again"
  end
end

def show_students
  print_header
  print_list
  print_footer
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
     #students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student record hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} student#{@students.count != 1 ? "s" : ""}"
    # get another name from the user
    name = gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_list
# previously used .each method as follows:
#  records.each.with_index(1) do |record, index|
#    puts "#{index}: #{record[:name]} (#{record[:cohort]} cohort)"
  k = 0
  while @students[k] do
    puts "#{k+1}: #{@students[k][:name]} (#{@students[k][:cohort]} cohort)"
    k += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{@students.count != 1 ? "s" : ""}"
end

# call the menu
interactive_menu