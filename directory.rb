# put all the students into an array
=begin
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},                                      
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
=end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} student#{students.count != 1 ? "s" : ""}"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "--------------------------------".center(40)
end

def print(records)
#  records.each.with_index(1) do |record, index|
#    puts "#{index}: #{record[:name]} (#{record[:cohort]} cohort)"
  k = 0
  while records[k] do
    puts "#{k+1}: #{records[k][:name]} (#{records[k][:cohort]} cohort)"
    k += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great student#{names.count != 1 ? "s" : ""}"
end

# now call the methods

students = input_students
print_header
print(students)
print_footer(students)