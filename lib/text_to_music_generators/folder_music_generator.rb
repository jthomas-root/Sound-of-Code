require "./lib/file_parser"
require "./lib/sound_generator"

module TextToMusicGenerator
  module FolderMusicGenerator
    GENERATED_MUSIC_FOLDER = "generated_music"
    OUTPUT_FILE_NAME = "generated_output_test"

    def self.generate(folder_path, music_generator)
      all_files = _all_files_in_folder(folder_path)
      puts "Found #{all_files.count} files"

      buffers = []
      all_files.each.with_index do |file_path, i|
        file_name = File.basename(file_path, ".*")
        puts "Working on #{file_name}"

        stats = FileParser.parse(file_path)
        music = music_generator.generate(stats)
        buffers << SoundGenerator.new(:tempo => 160).generate(music)
      end

      output_path = SoundGenerator.create_file_from_multiple_buffers(buffers, OUTPUT_FILE_NAME)
      File.basename(output_path)
    end

     private

     def self._all_files_in_folder(path)
      items = Dir.entries(path).tap do |arr|
        arr.delete(".")
        arr.delete("..")
      end
    
      result = []
      items.each do |item|
        item_path = "#{path}/#{item}"
        if File.directory?(item_path)
          result = result + _all_files_in_folder(item_path)
        else
          result << item_path
        end
      end
    
      result
    end
  end
end