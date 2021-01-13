module Song
  NOTES = {
    :A => :A,
    :B_F => :B_F,
    :B => :B,
    :C => :C,
    :D_F => :D_F,
    :D => :D,
    :E_F => :E_F,
    :E => :E,
    :F => :F,
    :G_F => :G_F,
    :G => :G,
    :A_F => :A_F,
  }

  OCTAVE_NOTES = NOTES.keys

  C_SCALE = [
    :C,
    :D,
    :E,
    :F,
    :G,
    :A,
    :B,
    :C
  ]

  REST = :rest

  RHYTHMS = {
    :whole => :whole,
    :half => :half,
    :quarter => :quarter,
    :eigth => :eigth,
    :sixteenth => :sixteenth,
  }

  NOTE_WAVE_TYPES = {
    :square => :square,
    :sine => :sine,
  }
end