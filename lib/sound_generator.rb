require "bundler/setup"
require "wavefile"
require "./lib/song"

class SoundGenerator
  
  SAMPLE_FREQUENCY = 44100

  NOTE_FREQUENCIES = {
    Song::REST => 0,
    Song::NOTES[:A] => 440,
    Song::NOTES[:B_F] => 466,
    Song::NOTES[:B] => 494,
    Song::NOTES[:C] => 523,
    Song::NOTES[:D_F] => 554,
    Song::NOTES[:D] => 587,
    Song::NOTES[:E_F] => 622,
    Song::NOTES[:E] => 659,
    Song::NOTES[:F] => 698,
    Song::NOTES[:G_F] => 734,
    Song::NOTES[:G] => 784,
    Song::NOTES[:A_F] => 830,
  }

  def initialize(tempo: 120)
    beats_per_second = tempo / 60
    seconds_per_beat = 1.0 / beats_per_second
    @seconds_for_note = {
      :whole => seconds_per_beat * 4,
      :half => seconds_per_beat * 2,
      :quarter => seconds_per_beat,
      :eigth => seconds_per_beat / 2,
      :sixteenth => seconds_per_beat / 4
    }
  end

  def self.create_file(buffer, output_file_name)
    file_path = "#{Dir.pwd}/#{output_file_name}.wav"
    WaveFile::Writer.new(file_path, WaveFile::Format.new(:mono, :pcm_16, 44100)) do |writer|
      writer.write(buffer)
    end

    file_path
  end

  def self.create_file_from_multiple_buffers(buffers, output_file_name)
    file_path = "#{Dir.pwd}/#{output_file_name}.wav"
    WaveFile::Writer.new(file_path, WaveFile::Format.new(:mono, :pcm_16, 44100)) do |writer|
      buffers.each { |buffer| writer.write(buffer) }
    end

    file_path
  end

  def generate(music)
    notes_in_music = music.map do |sound|
      notes = sound[:notes]
      octaves = sound[:octaves] || 0
      rhythm = sound[:rhythm]
      wave_type = sound[:wave_type] || Song::NOTE_WAVE_TYPES[:square]

      # check if single note or chord
      notes = [notes] unless notes.is_a? Array

      octaves = ([octaves] * notes.count) unless octaves.is_a? Array
      note_cycles = notes.zip(octaves).map do |(n, octave)|
        frequency = (NOTE_FREQUENCIES[n] * (2**(octave || 0)))
        time_length_of_note = @seconds_for_note[rhythm]

        if wave_type == Song::NOTE_WAVE_TYPES[:square]
          one_cycle = _square_cycle_for_freq(frequency)
        else
          one_cycle = _sine_cycle_for_freq(frequency)
        end
        _cycles(one_cycle, frequency, time_length_of_note)
      end

      sound = _create_cord(note_cycles)
    end

    notes_in_music = notes_in_music.flatten
    buffer = WaveFile::Buffer.new(notes_in_music, WaveFile::Format.new(:mono, :float, SAMPLE_FREQUENCY))
    buffer
  end

  private

  def _square_cycle_for_freq(freq)
    return [0] if freq == 0

    amplitude = 0.075
    half_cycle = (SAMPLE_FREQUENCY / freq / 2)
    ([amplitude] * half_cycle) + ([-amplitude] * half_cycle)
  end

  def _sine_cycle_for_freq(freq)
    return [0] if freq == 0

    amplitude = 0.25
    how_many_data_points_for_wave = SAMPLE_FREQUENCY / freq

    data_points = []
    how_many_data_points_for_wave.floor.times do |i|
      x = how_many_data_points_for_wave

      data_points << amplitude * Math.sin(2 * Math::PI * (i.to_f / how_many_data_points_for_wave))
    end

    data_points
  end
  
  def _cycles(cycle, freq, seconds)
    silent_time = 0.01
    on = freq * (seconds - silent_time)
    off = freq * silent_time
    result = cycle * on
    result
  end

  def _create_cord(note_cycles)
    shortest_note_length = note_cycles.map(&:count).min
    result = Array.new(shortest_note_length)

    # puts note_cycles.to_s
    shortest_note_length.times do |i|
      result[i] = note_cycles.map { |arr| arr[i] }.sum
    end

    result
  end
end