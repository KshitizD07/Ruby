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
    puts "\n"

    #Defining headings and rows
    headings = ['BMI Range', "Classification", "Health Risk"]
    rows=[
        ["Under 18.5", "Underweight", "Minimal to increased"],
        ["18.5 - 24.9", "Normal Weight", "Minimal"],
        ["25.0 - 29.9", "Overweight", "Increased"],
        ["30.0 and above", "Obese", "High to Extremely High"]
    ]

    #Building the table object
    table = Terminal::Table.new do |t|
        t.title = $pastel.cyan.bold("BMI Classification Reference")
        t.headings = headings.map { |h| $pastel.bold.italic(h) }
        t.rows = rows

        #Addidng styling options
        t.style = {
            border: :unicode,
            alignment: :center,
            all_separators: true
        }
    end

    #Prints the table
    puts table
    puts "\n"
end


#This welcomes the user with a nice message when they start the program.
def show_welcome_screen
    system("clear") || system("cls")  #This line clears the terminal screen before displaying the welcome message. It works for both Unix-based and windows ssytems.
    puts $pastel.cyan.bold("="*50)
    puts $pastel.cyan.bold("     WELCOME TO THE PREMIUM BMI CALCULATOR!!     ")
    puts $pastel.cyan.bold("="*50)
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