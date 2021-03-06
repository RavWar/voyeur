$: << "#{File.dirname(File.absolute_path(__FILE__))}/../lib" 
require "voyeur"

if ARGV.length < 2
  puts "Usage: voyeur.rb <filename> <format>"
  exit 1
end

file_to_convert = ARGV[0]
format = ARGV[1]

puts "Converting #{file_to_convert} to #{format}"

video = Voyeur::Media.new(filename: "#{file_to_convert}")


video.convert(to: format.to_sym) do |time|
  media_time = Voyeur::MediaTime.new(time).to_seconds
  duration = Voyeur::MediaTime.new(video.raw_duration).to_seconds
  percentage = (media_time.to_f/duration.to_f) * 100
  puts "#{'%.2f' % percentage} % complete"
end
