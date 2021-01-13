require "./lib/sound_generator"
require "./lib/song"

happy_birthday = [
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
    :octaves => [-1],
    :wave_type => :sine
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
    :octaves => [-1]
  },
  #
  {
    :notes => [Song::NOTES[:A]],
    :rhythm => :quarter
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :quarter,
    :octaves => [-1],
  },
  {
    :notes => [Song::NOTES[:C]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:B]],
    :rhythm => :half,
  },
  #
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
    :octaves => [-1],
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
    :octaves => [-1],
  },
  {
    :notes => [Song::NOTES[:A]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :quarter,
    :octaves => [-1],
  },
  {
    :notes => [Song::NOTES[:D]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:C]],
    :rhythm => :half,
  },
  #
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
    :octaves => [-1],
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
    :octaves => [-1],
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:E]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:C], Song::NOTES[:A]],
    :rhythm => :quarter,
    :octaves => [0, 1],
  },
  {
    :notes => [Song::NOTES[:B], Song::NOTES[:G]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:A], Song::NOTES[:F]],
    :rhythm => :half,
  },
  #
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
  },
  {
    :notes => [Song::NOTES[:G]],
    :rhythm => :eigth,
  },
  {
    :notes => [Song::NOTES[:E]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:C]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:B], Song::NOTES[:D]],
    :rhythm => :quarter,
  },
  {
    :notes => [Song::NOTES[:G], Song::NOTES[:C], Song::NOTES[:E]],
    :rhythm => :half,
    :octaves => [-1, 0, 0],
    :wave_type => :sine
  },
]

buffer = SoundGenerator.new(:tempo => 120).generate(happy_birthday)
SoundGenerator.create_file(buffer, "happy_birthday")