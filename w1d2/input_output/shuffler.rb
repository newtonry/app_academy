def get_filename
  puts "Input filename:"
  gets.chomp
end


def write_file filename, shuffled_data

  filename, extension = filename.split('.')

  File.open("#{filename}-shuffled.#{extension}", "w") do |f|
    shuffled_data.each do |line|
      f.puts line
    end
  end
end


filename = get_filename
shuffled_array = File.readlines(filename).shuffle

write_file filename, shuffled_array