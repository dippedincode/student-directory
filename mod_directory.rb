def input_students    # manual student name entry
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

def print_header(letter)
  puts "The students of Villains Academy whose name begins with " + letter.upcase
  puts "-------------"
end

def print_list(records, letter)
  k = 1
  records.each do |record, index|
    if record[:name][0].upcase == letter.upcase && record[:name].length < 12
      puts "#{k}: #{record[:name]} (#{record[:cohort]} cohort)"
      k += 1
    else
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great student#{names.count != 1 ? "s" : ""}"
end

# now call the methods

students = input_students
print "Which first letter do you want to a list of students for? "
letter = gets.chomp
print_header(letter)
print_list(students, letter)
print_footer(students)