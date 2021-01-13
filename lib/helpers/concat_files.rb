require "./lib/wavefile_manager"

folder_path = ARGV[0]
output_file_name = ARGV[1] || "concat_output.wav"
full_folder_path = "#{Dir.pwd}/#{folder_path}"

files = Dir.entries(full_folder_path).tap do |arr|
  arr.delete(".")
  arr.delete("..")  
end

file_paths = files.map do |file|
  "#{Dir.pwd}/#{folder_path}/#{file}"
end

WavefileManager.concat_files(output_file_name, file_paths)