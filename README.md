# Sound of Code
---

### Running the app
First run `bundle install` to install the necessary dependencies.

Then you can run the app by running the following command:
```
ruby ./main.rb [music_generator] [path_to_file_or_directory]
```
where
 - `[music_generator]` is the name of a music generator module found in the "lib/music_generator/" directory
 - `[path_to_file_or_folder]` is a path to either a file or a directory

Running this command will create a new wave file named "generated_output.wav".
Ex) `ruby ./main.rb OkayMusicGenerator "./lib"`

## Adding Additional Functionality

### Music Generator
To create new music, create a new module that can take in the features of a file and create a list of music notes.

This module needs to implement a `generate` method that takes in info about a file. Its return value needs to be an array of hashes representing each note in the music.
Each note hash in the array should have the following structure:
```ruby
{
  :notes => [Song::NOTES[:A], Song::NOTES[:C]], # Array of symbols representing the pitch(s) of this note.  Multiple notes in this array will create a chord
  :rhythm => Song::RHYTHMS[:quarter], # The length of the note
  :octaves => [0, -1], # (optional) The octave of the notes in the notes array.  0 means no change, positive integer means that many octaves above, negative integer means that many octave down
  :wave_type => :square, # (optional) Either :sine or :square.  Default is :square
}
```

Check out the "lib/happy_birthday.rb" file to see what the array of music notes should look like. For fun, you can run `ruby ./lib/happy_birthday.rb` to generate the wave file and sing along.

### Getting More File features
In order to get more features about a file, you can create file feature parsers.

This should be a module in the "lib/file_feature_parsers" directory. This module needs to implement both a `parse_lines` method and a `parse_file` method.
The `parse_line` method takes in a line of text and return any information about that line you want.
The `parse_file` method takes in all of the lines of text as an array of strings and returns any information you want about all of lines of text of a file.
Both of these information will be stored in an OpenStruct in the final info object.

Once you have created this module, you will need to update the `FileParser` module to require the new parser module and to add it to the `FileParser::PARSERS` hash. The key in the hash is the keyname used in the final info object and the value is the module itself.