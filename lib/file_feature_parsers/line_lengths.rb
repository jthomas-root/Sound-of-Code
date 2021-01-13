module LineLengths
  def self.parse_line(line)
    line.length - 1
  end

  def self.parse_file(lines)
    lengths = lines.map(&:length)

    OpenStruct.new(
      :max => lengths.max - 1,
      :min => lengths.min - 1,
    )
  end
end