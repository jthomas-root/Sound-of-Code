task default: %w[run]

task :run do
  ruby 'main.rb', 'OkayMusicGenerator', 'lib/file_parser.rb'
end

task :rp do
  ruby 'main.rb', 'lib/file_parser.rb'
  sh 'afplay', 'generated_output.wav'
end

task :concat, [:folder_path] do |t, args|
  ruby 'lib/helpers/concat_files.rb', args[:folder_path]
end