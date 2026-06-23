require 'tty-prompt'
require 'pastel'
require 'terminal-table'
require 'bundler/setup'
require 'json'

#Initialize helper classes from the gems we imported.
$prompt = TTY::Prompt.new
$pastel = Pastel.new


#Placeholder methods to fill in later. These methods will be used to calculate BMI and display the reuslts in a table format.

#Claculates BMI
def calculate_bmi(weight, height)
    (weight / (height**2)).round(2)
end

    #Return status based on BMI value
def get_calssification_details(bmi)
    if bmi < 18.5
        { status: "Underweight", color: :yellow }
    elsif bmi >= 18.5 && bmi <24.9
        { status: "Normal weight", color: :green }
    elsif bmi >= 25 && bmi < 29.9
        { status: "Overweight", color: :magenta }
    else
            { status: "Obese", color: :red }
    end
end    

def calculate_bmi_flow
    puts "\n"
    puts $pastel.cyan.bold("----BMI Calculator ---")

    #Asking for name
    name = $prompt.ask("Enter your name:") do |q|
        q.required true
        q.modify :capitalize
    end

    #Asking for weight with validation and automatice conversion to float.
    weight = $prompt.ask("Enter your weight in kg (e.g. 72.5):") do |q|
        q.required true
        q.validate(/^\d+(\.\d+)?$/, "Please enter a valid positive number.")
        q.convert :float
    end

    #Asking height
    height = $prompt.ask("Enter your height in meters (e.g. 1.75):") do |q|
        q.required true
        q.validate(/^\d+(\.\d+)?$/, "Please enter a valid positive number.")
        q.convert :float
    end

    #Perform calculations
    bmi = calculate_bmi(weight, height)
    details = get_calssification_details(bmi)

    #Saving the result
    save_result_to_history(name, weight, height, bmi, details[:status])

    #Displaying 
    puts "\n"
    puts $pastel.cyan.bold("="*35)
    puts "  RESULTS FOR #{name.upcase}:"
    puts $pastel.cyan.bold("=" *35)
    puts "  Weight:          #{weight} kg"
    puts "  Height:          #{height} m"
    puts "  Calculated BMI:  #{$pastel.bold(bmi)}"
    
    
    status_colored = $pastel.send(details[:color]).bold(details[:status])
    puts "  Classification:  #{status_colored}"
    puts $pastel.cyan.bold("="*35)
    puts "\n"
end

def save_result_to_history(name, weight, height, bmi, status)
    new_record = {
        name: name,
        weight: weight,
        height: height,
        bmi: bmi,
        status: status,
        date: Time.now.strftime("%Y-%m-%d %H:%M:%S")
    }

    #Load existing history
    history = []
    if File.exist?("bmi_history.json")
        file_content = File.read("bmi_history.json")
        history = JSON.parse(file_content)
    end

    #Adding the new record to our history array
    history << new_record

    #Save updated history back to the file
    File.write("bmi_history.json", JSON.pretty_generate(history))
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


def show_history
    system("clear") || system("cls")
    puts $pastel.cyan.bold("=" *50)
    puts $pastel.cyan.bold("          YOUR BMI HISTORY          ")
    puts $pastel.cyan.bold("=" *50)
    puts "\n"

    #Checking if history exists
    if !File.exist?("bmi_history.json")
        puts $pastel.yellow("Bo history found yet. GO calculate your BMI first!")
        puts "\n"
        return 
    end

    #Reading and parsing the data
    file_content = File.read("bmi_history.json")
    history = JSON.parse(file_content)

    #Handling the edge case where the file exists but is somehow empty
    if history.empty?
        puts $pastel.yellow("No history found yet. Go calculate your BMI first!")
        puts "\n"
        return 
    end

    #Preparing the rows for our table
    rows = []
    history.each do |record|
        rows << [record["date"], record["name"], record["weight"], record["height"], record["bmi"], record["status"]]
    end

    #Building and printing the table
    table = Terminal::Table.new do |t|
        t.headings = ["Date", "Name", "Weight(kg)", "Height(m)", "BMI", "Status"].map { |h| $pastel.bold.italic(h) }
        t.rows = rows
        t.style = {
            border: :unicode,
            alignment: :center,
            all_separators: true
        }
    end

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
            menu.choice "View History", :history
            menu.choice "View Classification Table", :table
            menu.choice "Exit", :exit
        end

        case choice
        when :calculate
            calculate_bmi_flow
            $prompt.keypress("Press any key to return to main menu...")
        when :history
            show_history
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