require 'tty-prompt'
require 'pastel'
require 'terminal-table'
require 'bundler/setup'

#Initialize helper classes from the gems we imported.
$prompt = TTY::Prompt.new
$pastel = Pastel.new


#Placeholder methods to fill in later. These methods will be used to calculate BMI and display the reuslts in a table format.

def calculate_bmi_flow
    puts $pastel.yellow("Calculating BMI...")
end

def show_classification_table
    puts $pastel.yellow("Displaying BMI Classification Table...")
end


#This welcomes the user with a nice message when they start the program.
def show_welcome_screen
    system("clear") || system("cls")  #This line clears the terminal screen before displaying the welcome message. It works for both Unix-based and windows ssytems.
    puts $pastel.cyan.bold("="*45)
    puts $pastel.cyan.bold("     WELCOME TO THE PREMIUM BMI CALCULATOR!!     ")
    puts $pastel.cyan.bold("="*45)
    puts "\n"
end

#Controls the menu choices and loop
def start_app
    loop do
        show_welcome_screen

        #Renders an interactive arrow-key menu
        choice = $prompt.select("What would you like to do?") do |menu|
            menu.choice "Calculate BMI", :calculate
            menu.choice "View Classification Table", :table
            menu.choice "Exit", :exit
        end

        case choice
        when :calculate
            calculate_bmi_flow
            $prompt.keypress("Press any key to return to main menu...")
        when :table
            show_classification_table
            $prompt.keypress("Press any key to return to main menu...")
        when :exit
            puts $pastel.green("Thank you for using the BMI Calculator. Goodbye!!")
            break #exits the loop
        end
    end
end

#To start the application
start_app