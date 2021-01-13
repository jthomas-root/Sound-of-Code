require "bundler/setup"
require "wavefile"

module WavefileManager
  include WaveFile

  def self.concat_files(output_name, files_to_append)
    Writer.new(output_name, Format.new(:stereo, :pcm_16, 44100)) do |writer|
      files_to_append.each do |file_name|
        Reader.new(file_name).each_buffer do |buffer|
          writer.write(buffer)
        end
      end
    end
  end
end