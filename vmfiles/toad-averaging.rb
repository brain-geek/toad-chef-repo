files = Dir.glob('*-0').sort

require 'csv'

puts "Filename;Avg response time;Number of requests per second"
files.each do |filename|
  number = 0
  time_sum = 0

  4.times do |file_number|
    records = 0
    f = filename[0...-1]+file_number.to_s

    CSV.foreach(f, :col_sep => ';') do |row|
      records = records + 1
      time_sum += row[0].to_f
    end

    puts "#{f} has #{records} records"
    number = number + records
  end

  puts "#{filename};#{((time_sum/number)/1000).round(2)};#{(number.to_f/60).round(2)}".gsub('.', ',')
end

