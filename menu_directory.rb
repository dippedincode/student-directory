require 'date'

@students = []  # an empty array accessible to all methods

def print_menu
  puts "1. Input student data"
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
  puts "You chose 2 - Show the students list" 
  if @students.count != 0
    print_header
    print_list
    print_footer
  else
    puts "Currently there are no students at Villains Academy."
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def input_students
  puts "You chose 1 - Input student data"
  puts "Please enter the student's name"
  puts "To finish, just hit return again"
  name = STDIN.gets.chomp
  # while name is not empty, repeat this code
  while !name.empty? do
    # add the student record hash to the array
    push_to_arr({name: name, cohort: "undefined", "age" => 0})
    puts "Please enter the month of the student's cohort"
    loop do
      cohort = STDIN.gets.chomp
      cohort = cohort.strip.capitalize
      if !cohort.empty? && Date::MONTHNAMES.include?(cohort)
        @students.last[:cohort] = cohort
        #puts "Now we have #{@students.count} student#{@students.count != 1 ? "s" : ""}"
        #puts "Please enter the next student's name"
        #puts "To finish, just hit return again"
        break
      else
        puts "That is an invalid month, please try again"
      end 
    end
    puts "Please enter the student's age (years)"
    loop do
      age = STDIN.gets.chomp
      age = age.strip.to_i
      if age > 0
        @students.last["age"] = age
        puts "Now we have #{@students.count} student#{@students.count != 1 ? "s" : ""}"
        puts "Please enter the next student's name"
        puts "To finish, just hit return again"
        break
      else
        puts "That is an invalid age, please try again"
      end 
    end
    name = STDIN.gets.chomp   # get another name
  end
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "--------------------------------".center(40)
end

def print_list
# previously used .each method as follows:
#  array.each.with_index(1) do |record, index|
#    puts "#{index}: #{record[:name]} (#{record[:cohort]} cohort)"
  by_months = Hash.new()
  Date::MONTHNAMES.drop(1).each do |month|
    @students.each do |student|
      by_months[month] = [] unless by_months.has_key?(month)
      by_months[month].push(student) if month == student[:cohort]
    end
  end
  by_months.each do |month, stud_arr|
    print "    Students in #{month} cohort : "
    if stud_arr.empty?
      print "none"
      puts
    else 
      puts
      stud_arr.each.with_index(1) do |student, index|
      puts "        #{index}: #{student[:name]}, age #{student["age"]}"
      end
    end
  end
end

=begin   alternative way of doing numerated list  
  k = 0
  while @students[k] do
    puts "    #{k+1}: #{@students[k][:name]} (#{@students[k]["cohort"]} cohort)"
    k += 1
  end
=end

def print_footer
  puts "Overall, we have #{@students.count} great student#{@students.count != 1 ? "s" : ""}".center(40)
end

def save_students
  puts "You chose 3 - Save the list to students.csv"
  file = File.open("students.csv", "w")
  @students.each do |student|   # iterate over the array of student records
    student_data = [student[:name], student[:cohort], student["age"]]   # convert hash to an array
    csv_line = student_data.join(",")   # turn that array into string "a,b,c"
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  puts "You chose 4 - Load the list from students.csv"
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, age = line.chomp.split(",")
    push_to_arr({name: name, cohort: cohort, "age" => age})
  end
  file.close
end

def push_to_arr(record)
  @students << record
end

def clear_list_memory
  puts "You chose 5 - Clear the list from program memory"
  @students = []
end

def clear_students_file
  puts "You chose 6 - Clear the file students.csv"
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