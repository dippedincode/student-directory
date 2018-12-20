@students = []  # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students list"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Clear the list from program memory"
  puts "6. Clear the file students.csv"
  puts "9. Exit"
  puts "Enter a number:"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students   
  when "4" 
    load_students   # now this will load from students.csv by default
  when "5"
    clear_list_memory
  when "6"
    clear_students_file
  when "9"
    exit  # this will stop the program
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
    process(STDIN.gets.chomp)
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student record hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} student#{@students.count != 1 ? "s" : ""}"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_list
# previously used .each method as follows:
#  array.each.with_index(1) do |record, index|
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

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|   # iterate over the array of student records
    student_data = [student[:name], student[:cohort]]   # convert hash to an array
    csv_line = student_data.join(",")   # turn that array into string "a,b"
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def clear_list_memory
  @students = []
end

def clear_students_file
  file = File.open("students.csv", "w")
  file.print ""   # overwrite whatever is in the file with no character
  file.close
end

def try_load_students
  filename = ARGV.first   # first argument from the command line
  return if filename.nil?   # get out of the method if it isn't given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

# load students and call the menu
try_load_students
interactive_menu