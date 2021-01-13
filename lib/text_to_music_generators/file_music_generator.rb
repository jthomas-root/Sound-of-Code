require "./lib/file_parser"
require "./lib/sound_generator"

module TextToMusicGenerator
  module FileMusicGenerator
    OUTPUT_FILE_NAME = "generated_output"

    def self.generate(file_path, music_generator)
      stats = FileParser.parse(file_path)
      music = music_generator.generate(stats)
      generated_music_buffer = SoundGenerator.new(:tempo => 160).generate(music)
      output_path = SoundGenerator.create_file(generated_music_buffer, OUTPUT_FILE_NAME)
      File.basename(output_path)
    end
  end
end