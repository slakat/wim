require 'smarter_csv'


filename = 'scripts/cuentas.csv'
puts filename
options = {:key_mapping =>{ :name => :name, :username => :screen_name}, :remove_unmapped_keys => true, :verbose => false }

n = SmarterCSV.process(filename, options) do |array|
  # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
  # when chunking is not enabled, there is only one hash in each array
  original_username = array.first.values.second
  value = array.first.values.second.downcase
  array.first[:screen_name] =  value
  puts array.first.values.second
  replicate = Actor.find_by_screen_name(value)
  if replicate.nil?
    Actor.create!( array.first )
  else
    replicate.real_username = original_username
    replicate.save
    puts replicate.real_username
  end
end

