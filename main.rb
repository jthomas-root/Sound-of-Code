Dir[File.join(__dir__, 'lib', 'text_to_music_generators', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', 'music_generator', '*.rb')].each { |file| require file }

music_generator_name = ARGV[0]
raw_path = ARGV[1]

if !music_generator_name
  puts %(Must specify a music generator module name found in the "music_generator" folder)
  return 1
end

if !raw_path
  puts %(Must specify a path)
  return 1
end

if !Dir.exist?(raw_path) && !File.exist?(raw_path)
  puts %(No file or folder exists at path "#{raw_path}")
  return 1
end

music_generator_module = Object.const_get(music_generator_name)

output_file_name = if File.directory?(raw_path)
  puts "Generating music for folder..."
  TextToMusicGenerator::FolderMusicGenerator.generate(raw_path, music_generator_module)
else
  puts "Generating music for file..."
  TextToMusicGenerator::FileMusicGenerator.generate(raw_path, music_generator_module)
end

puts %(Created your music file: "#{output_file_name}")

