require 'csv'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

#Filename structure: log<id>.log-<worker>


puts "Filename;Avg response time;Number of requests per second"
(1..20).each do |experiment_id|
  number = 0
  time_sum = 0

  4.times do |worker_id|
    records = 0

    f = "log#{experiment_id}.log-#{worker_id}"

    CSV.foreach(f, :col_sep => ';') do |row|
      records = records + 1
      time_sum += row[0].to_f
    end

    #puts "#{f} has #{records} records"
    number = number + records
  end

  puts "#{experiment_id};#{((time_sum/number)/1000).round(2)};#{(number.to_f/180).round(2)}".gsub('.', ',')
end

