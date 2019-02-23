=begin
    To Do:
    - Add checks for invalid input:
        - less than 10 characters
        - invalid Y/M/D values (eg. 0101 -1 99)
        - regex pattern matching?
=end

# @method:  get_century_code
# @desc:    match the given century to a value in the century_codes hash/table.
# @inputs:  century : int : expects two digits
# @output:  century_code : int
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
    century_code = century_codes[i]
  elsif century > 20
    i -= 4 until i <= 20
    century_code = century_codes[i]
  else
    century_code = century_codes[i]
  end
end

# @method:  is_leap_year
# @desc:    calculate whether the given year is a leap year or not
# @inputs:  date : string : expects first 4 characters to be the year
# @output:  boolean
def is_leap_year date
  year = date[0..3].to_i
  if (year % 4) != 0
    # leap years are all perfectly divisible by four
    false
  elsif ((year % 100) == 0) and ((year % 400) != 0)
    # years that are divisible by 100 and not by 400 are not leap years
    false
  else
    true
  end
end

# @method:  get_weekday_from_date
# @desc:    calculate what day of the week a given date lands on
# @inputs:  date : string : expects 10 characters in the following format: "YYYY MM DD"
# @output:  weekday : string
def get_weekday_from_date date
  # Using 'The Key Value Method' for getting the weekday of any date (in the Gregorian calendar)
  # which I found at http://mathforum.org/dr.math/faq/faq.calendar.html
  weekday = nil
  century = date[0..1].to_i # first two digits of the year
  year    = date[2..3].to_i # last two digits of the year
  month   = date[5..6].to_i
  day     = date[8..9].to_i

  month_values = {
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

  # Divide the last two digits of the year by 4
  weekday = year / 4
  # Add the day of the month.
  weekday += day
  # Add the month's key value
  weekday += month_values[month]
  # If the date is in January or February of a leap year, subtract 1.
  if month == 1 or month == 2
    if is_leap_year date
      weekday -= 1
    end
  end
  # Add the century code
  weekday += get_century_code century
  # Add the last two digits of the year
  weekday += year
  # Divide by 7 and take the remainder
  weekday = weekday % 7

  # The value of 'weekday' should now be an integer from 1-7 which will correspond
  #     with a day of the week. (0 => Sat, 1 => Sun, ...6 => Thu, 7 => Fri)
  # Storing the weekdays in an array such that the index of each value 
  #     matches the corresponding value of 'weekday'.
  weekdays = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

  # Implicit return value (string)
  weekday = weekdays[weekday]
  
end

# Ask the user for input
puts "Please enter a date: (YYYY MM DD)"
puts "(eg. 2019 01 25)"

# Retrieve user input
date = gets.chomp

# Output result to user
weekday = get_weekday_from_date date
puts "#{date} lands on a #{weekday}."

=begin
A note about calculating leap years (from timeanddate.com/date/leapyear.html):

  In the Gregorian calendar three criteria must be taken into account to identify leap years:

  * The year can be evenly divided by 4;
  * If the year can be evenly divided by 100, it is NOT a leap year, unless;
  * The year is also evenly divisible by 400. Then it is a leap year.
  
  This means that in the Gregorian calendar, the years 2000 and 2400 are leap years, 
  while 1800, 1900, 2100, 2200, 2300 and 2500 are NOT leap years.

=end
