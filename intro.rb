=begin

print "Hello, World!\n"
puts "Hello, Ruby!"
print "This is a simple Ruby script."

#This is a comment in Ruby.
=begin
this is a 
multi-line 
    comment in Ruby.

name= "KSHITIZ"
puts "My name is #{name}."
age=20
# name="KZ"
puts "My name is #{name}, #{age} years old."

puts name.class
puts age.class
puts name.length
puts name.upcase
puts name.downcase
puts name.reverse
puts name.include?("K")
puts name[0]
puts name[1]
puts name[0..4]
x= name.split("I")
puts name.strip

puts x.join

puts x.inspect #this will print the array in a readable format

arr=[1,2,3]
print arr



dict={:name=>"KSHITIZ", :age=>20}
puts dict[:name]

a,b,c=1,2,3
puts "{#{a}, #{b}, #{c}}"

a,b=b,a
puts "{#{a}, #{b}, #{c}}"

arr=[1,2,3,4,5]
a,b,*c=arr
puts "{#{a}, #{b}, #{c}}"




# 5.times do |i| #This is similar to a for loop that runs 5 times in Ruby.
#     puts "Iteration #{i+1}"



puts 5<=>5 #This is the sapceship operator in Ruby.

puts 'a'==='A' #It is used to check if the value on the left is equal to the value on the right. It returns true if they are equal, and false otherwise.
#It is different fromthe == operator, which checks for value equality. The === operator is used in case statements and is also known as the case equality operator.

puts 'a'=='A'




a=true
b=false

puts a and b #It's true because the and operator has lower precedence than the assignment operator, so it evaluates to true and assigns the value to b.
puts a or b
puts a && b
puts a || b
puts not a
puts !a




puts (1..5).to_a
puts (1...5).to_a
puts ('a'..'z').to_a
(1..5).each do |i|#this is a loop that iterates through the range from 1 to 5 and prints each number. 
    puts i
end

=end

name="KZ"
puts defined? name
puts $_

