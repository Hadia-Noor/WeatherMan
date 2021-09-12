def is_valid_year? year
  return false if year.to_i.to_s != year
  year.strip.to_i.between?(2003, 2017)
end
def colorize(value, color)
	case color
		when :red then "\e[31m" + value.to_s + "\e[0m"
		when :green then "\e[32m" + value.to_s + "\e[0m"
		when :yellow then "\e[33m" + value.to_s + "\e[0m"
		when :blue then "\e[34m" + value.to_s + "\e[0m"
		when :bright_red then "\e[1m\e[31m" + value.to_s + "\e[0m"
		when :bright_green then "\e[1m\e[32m" + value.to_s + "\e[0m"
		when :bright_yellow then "\e[1m\e[33m" + value.to_s + "\e[0m"
		when :bright_blue then "\e[1m\e[34m" + value.to_s + "\e[0m"
		else value.to_s
	end
end
puts "e: Year"
puts "a: Month"
puts "c: Chart"
puts "Enter Choice"
inp = gets.chomp.to_s
case inp
when 'a'
  require 'csv'
  MaxTemp = []
  MinTemp = []
  MaxDate = []
  MinDate = []
  MaxHumid = []
  HumidDay = []
  puts "Enter Month"
  input = gets.chomp.to_s
    files=Dir["/mnt/e/Ruby/WeatherMan/**/*.txt"]
    files.each do |file_name|
      if !File.directory? file_name and file_name.include? input
        CSV.foreach((file_name.to_s), headers: true, col_sep: ",") do |row|
          if row[2].nil? || row[2].length > 2
          else
            MaxTemp << row[2]
            MaxDate << row[0]
          end
          if row[2].nil? || row[2].length > 2
          else
            MinTemp << row[2]
            MinDate << row[0]
          end
          if row[8].nil? || row[8].length > 2
          else
            MaxHumid << row[8]
            HumidDay << row[0]
          end
        end
      end
    end
    puts MaxTemp
    maxmonth =  Date::MONTHNAMES[MaxDate[MaxTemp.index(MaxTemp.max())][5].to_i]
    maxday = MaxDate[MaxTemp.index(MaxTemp.max())][7..-1].to_i
    maxyear = MaxDate[MaxTemp.index(MaxTemp.max())][0..4].to_i
    maxtemp = MaxTemp.max()
    minmonth = Date::MONTHNAMES[MinDate[MinTemp.index(MinTemp.min())][5].to_i]
    minday = MinDate[MinTemp.index(MinTemp.min())][7..-1].to_i
    minyear = MinDate[MinTemp.index(MinTemp.min())][0..4].to_i
    mintemp = MinTemp.min()
    hmonth = Date::MONTHNAMES[HumidDay[MaxHumid.index(MaxHumid.max())][5].to_i]
    hday = HumidDay[MaxHumid.index(MaxHumid.max())][7..-1].to_i
    hyear = HumidDay[MaxHumid.index(MaxHumid.max())][0..4].to_i
    htemp = MaxHumid.max()
  puts "Highest Average: #{maxtemp}C on " + maxmonth.to_s + " #{maxday}"
  puts "Lowest Average: #{mintemp}C on " + minmonth.to_s + " #{minday}"
  puts "Average Humidity: #{htemp}% on " + hmonth.to_s + " #{hday}"
when 'e'
require 'csv'
  MaxTemp = []
  MinTemp = []
  MaxDate = []
  MinDate = []
  MaxHumid = []
  HumidDay = []
  puts "Enter Year"
  input = gets.chomp.to_s
  if is_valid_year?(input)
    files=Dir["/mnt/e/Ruby/WeatherMan/**/*.txt"]
    files.each do |file_name|
      if !File.directory? file_name and file_name.include? input
        CSV.foreach((file_name.to_s), headers: true, col_sep: ",") do |row|
          if row[1].nil? || row[1].length > 2
          else
            MaxTemp << row[1]
            MaxDate << row[0]
          end
          if row[3].nil? || row[3].length > 2
          else
            MinTemp << row[3]
            MinDate << row[0]
          end
          if row[7].nil? || row[7].length >2
          else
            MaxHumid << row[7]
            HumidDay << row[0]
          end
        end
      end
    end
    maxmonth =  Date::MONTHNAMES[MaxDate[MaxTemp.index(MaxTemp.max())][5].to_i]
    maxday = MaxDate[MaxTemp.index(MaxTemp.max())][7..-1].to_i
    maxyear = MaxDate[MaxTemp.index(MaxTemp.max())][0..4].to_i
    maxtemp = MaxTemp.max()
    minmonth = Date::MONTHNAMES[MinDate[MinTemp.index(MinTemp.min())][5].to_i]
    minday = MinDate[MinTemp.index(MinTemp.min())][7..-1].to_i
    minyear = MinDate[MinTemp.index(MinTemp.min())][0..4].to_i
    mintemp = MinTemp.min()
    hmonth = Date::MONTHNAMES[HumidDay[MaxHumid.index(MaxHumid.max())][5].to_i]
    hday = HumidDay[MaxHumid.index(MaxHumid.max())][7..-1].to_i
    hyear = HumidDay[MaxHumid.index(MaxHumid.max())][0..4].to_i
    htemp = MaxHumid.max()
  else
    puts "Invalid Year"
  end
  puts "Highest: #{maxtemp}C on " + maxmonth.to_s + " #{maxday}"
  puts "Lowest: #{mintemp}C on " + minmonth.to_s + " #{minday}"
  puts "Humidity: #{htemp}% on " + hmonth.to_s + " #{hday}"
when 'c'
  require 'csv'
  MaxTemp = []
  MinTemp = []
  puts "Enter Month"
  input = gets.chomp.to_s
    files=Dir["/mnt/e/Ruby/WeatherMan/**/*.txt"]
    files.each do |file_name|
      if !File.directory? file_name and file_name.include? input
        CSV.foreach((file_name.to_s), headers: true, col_sep: ",") do |row|
          if row[1].nil?
          else
            MaxTemp << row[1]
          end
          if row[3].nil?
          else
            MinTemp << row[3]
          end
        end
      end
    end
    max1temp = MaxTemp[0].to_i
    max2temp = MaxTemp[1].to_i
    min1temp = MinTemp[0].to_i
    min2temp = MinTemp[1].to_i
    print "01"
    max1temp.times{print colorize("+", :bright_blue)}
    puts "#{max1temp}C"
    print "01"
    min1temp.times{print colorize("+", :bright_red)}
    puts "#{min1temp}C"
    print "02"
    max2temp.times{print colorize("+", :bright_blue)}
    puts "#{max2temp}C"
    print "02"
    min2temp.times{print colorize("+", :bright_red)}
    puts "#{min2temp}C"

  else
  end
