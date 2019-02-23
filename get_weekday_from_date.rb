# THIS METHOD ASSUMES THE GIVEN 'DATE' ARGUMENT IS A STRING IN THE FOLLOWING FORMAT "YYYY MM DD"

def get_weekday_from_date date
  # Using 'The Key Value Method' for getting the weekday of any date (in the Gregorian calendar)
  # which I found at http://mathforum.org/dr.math/faq/faq.calendar.html

  weekday = nil # will act as running total, then result string
  century = date[0..1].to_i # first two digits of the year
  year    = date[2..3].to_i #  last two digits of the year
  month   = date[5..6].to_i
  day     = date[8..9].to_i

  month_codes = {
    1  => 1, # Jan
    2  => 4, # Feb
    3  => 4, # Mar
    4  => 0, # Apr
    5  => 2, # May
    6  => 5, # Jun
    7  => 0, # Jul
    8  => 3, # Aug
    9  => 6, # Sep
    10 => 1, # Oct
    11 => 4, # Nov
    12 => 6  # Dec
  }

  def get_century_code century
    century_codes = {
      17 => 4, # 1700s
      18 => 2, # 1800s
      19 => 0, # 1900s
      20 => 6  # 2000s
      # Gregorian calendar repeats every four hundred years
    }
    i = century
    if century < 17
      i += 4 until i >= 17
      code = century_codes[i]
    elsif century > 20
      i -= 4 until i <= 20
      code = century_codes[i]
    else
      code = century_codes[i]
    end
  end # of get_century_code century

  # Take the last two digits of the year
  # Divide by 4 and drop any remainder
  weekday = year / 4

  # Add the day of the month.
  weekday += day

  # Add the month's key value
  weekday += month_codes[month]

  # If the date is in January or February of a leap year, subtract 1.

  # Add the century code
  weekday += get_century_code century

  # Add the last two digits of the year
  weekday += year

  # Divide by 7 and take the remainder
  weekday = weekday % 7

  # The value of 'weekday' should now be an integer from 1-7 
  #   which will correspond with a day of the week.
  #   ( 0 => Sat, 1 => Sun, ...6 => Thu, 7 => Fri )
  # I'll store the weekdays in an array such that the index of each value 
  #   matches the corresponding value of 'weekday'.
  weekdays = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

  # Implicit return value (string)
  weekday = weekdays[weekday]
  
end

# Ask the user for input
puts "Please enter a date: (YYYY MM DD)(eg. 2019 12 25)"

# Retrieve user input
date = gets.chomp

# Output result to user
weekday = get_weekday_from_date date
puts "#{date} will be a #{weekday}."