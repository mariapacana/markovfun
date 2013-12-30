require "markovfun/version"

module Markovfun
  module Util

    # Gets lines from a file.
    def self.get_lines(filename)
      file = File.open(filename, "r")
      data = file.read
      file.close
      lines = data.split("\n")
      lines.map! { |l| l.strip.split(" ") }
    end

    # Gets sentences from a file.
    def self.get_sentences(filename)
      file = File.open(filename, "r")
      data = file.read
      file.close
      data.gsub!(/\n/, " ")
      data.gsub!(/"/,"")
      sentences = data.split(".")
      sentences.map! { |s| s.strip.split(" ").push(".") }
      sentences.select! { |s| s[0].capitalize == s[0] }
    end
  end
end