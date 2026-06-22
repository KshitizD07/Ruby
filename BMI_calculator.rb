puts "Welcome to the BMI Calculator!"

#This below is how you take input from the user in Ruby.

print "Enter your name:"
name=gets.chomp 

puts "Hello, #{name}! Let's calculate you BMI."

print "Do you want to see the BMI classification? (yes/no):"
show_classification=gets.chomp.downcase
if show_classification == "yes"
    puts "BMI Classification:"
    puts "Underweight: BMI < 18.5"
    puts "Normal weight: BMI 18.5 - 24.9"
    puts "Overweight: BMI 25 - 29.9"
    puts "Obesity: BMI >= 30"
end



print "Enter your weight in kg:"
weight=gets.chomp.to_f 

#gets takes input from the user and chomp removes the newline character from the input and to_f converts the input to float.
#Here we use chomp because when we take input from the user, it adds a newline character at the end of the input.
#The issue with that is when we try to convert the input to float, it will give an error because of the newline character.
#The newline character is used to indicate the end of a line of text and ruby adds it automatically because it is a commmon convention to end a line of text.

print "Enter your height in meters:"
height=gets.chomp.to_f

#This below is how you create a function in Ruby and call it when required.
def calculate_bmi(weight, height)
    bmi=weight/(height**2)
    return bmi.round(2)
end

def classify_bmi(bmi)
    if bmi < 18.5
        puts "Underweight"
    elsif bmi >= 18.5 && bmi <24.9
        puts "Normal weight"
    elsif bmi >= 25 && bmi <29.9
        puts "Overweight"
    else 
        puts "Obesity Overloaded"
    end
end


bmi=calculate_bmi(weight, height)
classify_bmi(bmi)