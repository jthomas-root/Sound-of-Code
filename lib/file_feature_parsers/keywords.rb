module Keywords
  KEYWORDS = [
    "class",
    "module",
    "def",
    "case",
    "do",
    "if",
    "else",
    "then",
    "elsif",
    "unless",
    "while",
  ]

  def self.parse_line(line)
    line.split(/\s/) & KEYWORDS
  end

  def self.parse_file(lines); end
end
