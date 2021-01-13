require "./lib/song"

module SimpleMusicGenerator
  def self.generate(info)
    max_line_length = info.file.line_length.max
    min_line_length = info.file.line_length.min

    info.lines.map do |line_info|
      line_length = line_info.line_length.to_f

      percentage_of_all_line_lengths = (line_length - min_line_length) / ((max_line_length - min_line_length) || 1)
      note_on_scale = percentage_of_all_line_lengths * (Song::OCTAVE_NOTES.count - 1)
      notes = Song::OCTAVE_NOTES[note_on_scale.round]

      {
        :notes => notes,
        :rhythm => Song::RHYTHMS[:sixteenth]
      }
    end
  end
end