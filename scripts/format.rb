def delete_lines_from_file(filename, lines_to_delete)
  line_arr = File.readlines(filename)
  unless line_arr.at(0).to_s.start_with?('created_at')
    (lines_to_delete).times  do
      line_arr.delete_at(0)
    end
    if line_arr.at(0).to_s.start_with?('--')
      line_arr.delete_at(0)
    end
  end
  File.open(filename, "w") do |f|
    line_arr.each{|line| f.puts(line)}
  end
end

Dir.foreach('tmp/test') do |item|
  next if item == '.' or item == '..'
  delete_lines_from_file('tmp/test/'+item,7)
end

