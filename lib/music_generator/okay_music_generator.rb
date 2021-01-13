require "./lib/song"

module OkayMusicGenerator
  def self.generate(info)
    max_line_length = info.file.line_length.max
    min_line_length = info.file.line_length.min

    info.lines.map do |line_info|
      line_length = line_info.line_length.to_f

      percentage_of_all_line_lengths = (line_length - min_line_length) / ((max_line_length - min_line_length) || 1)
      note_on_scale = percentage_of_all_line_lengths * (Song::OCTAVE_NOTES.count - 1)
      note_index = note_on_scale.round

      # Get note
      notes = [Song::OCTAVE_NOTES[note_index]]

      if line_info.keywords.include?("class")
        third_degree_index = (note_index + 3) % Song::OCTAVE_NOTES.count
        notes << Song::OCTAVE_NOTES[third_degree_index]
      end

      if line_info.keywords.include?("def")
        third_degree_index = (note_index + 5) % Song::OCTAVE_NOTES.count 
        notes << Song::OCTAVE_NOTES[third_degree_index]
      end

      # get rhythm length
      if line_info.keywords.include?("if") || line_info.keywords.include?("unless")
        rhythm = Song::RHYTHMS[:quarter]
      else
        rhythm = Song::RHYTHMS[:sixteenth]
      end

      {
        :notes => notes,
        :rhythm => rhythm
      }
    end
  end
end