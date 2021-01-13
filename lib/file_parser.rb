require "ostruct"

require "./lib/file_feature_parsers/keywords"
require "./lib/file_feature_parsers/line_lengths"

module FileParser
  PARSERS = {
    :keywords => Keywords,
    :line_length => LineLengths,
  }

  def self.parse(filepath)
    result = OpenStruct.new(:lines => [], :file => OpenStruct.new)
    lines_of_text = []

    # Get stats about each line
    File.foreach(filepath).with_index do |line, index|
      lines_of_text << line
      line_stats = OpenStruct.new

      PARSERS.each_pair do |key, parser|
        line_stats[key] = parser.parse_line(line)
      end

      result.lines << line_stats
    end

    # Get stats about the file as a whole
    file_stats = OpenStruct.new
    PARSERS.each_pair do |key, parser|
      file_stats[key] = parser.parse_file(lines_of_text)
    end
    result.file = file_stats

    result
  end
end