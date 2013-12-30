require "markovfun/version"
require "markovfun/util"

module Markovfun
  module Trigram
    include Markovfun::Util

    # Generates a sentence, given a file.
    def self.sentence_from_file(filename, min_length)
      sentences = get_sentences(filename)
      counts = get_counts(sentences)
      probs = counts_to_probs(counts)
      sentence_from_probs_hash(probs, min_length)
    end

    # Returns a counts hash, given a list of sentences.
    # The keys to the hash are all observed combinations of [prev2, prev1], 
    # where prev2 and prev1 are the two previous words. 
    # The values are hashes, in which the keys are words (cur) that have followed
    # prev2 and prev1, and the values are the number of occurrences.
    def self.get_counts(sentences)
      counts_hash = {}
      sentences.each do |sent|
        # nil denotes the beginnings and ends of sentences
        sent = [nil, nil] + sent + [nil]
        sent.zip(sent[1..-1], sent[2..-1]).each do |prev2, prev1, cur|
          counts_hash[[prev2, prev1]] ||= {}
          if !(counts_hash[[prev2, prev1]][cur])
            counts_hash[[prev2, prev1]][cur] = 1
          else
            counts_hash[[prev2, prev1]][cur] += 1
          end
        end
      end
      counts_hash
    end

    # Generates a probability hash, given a counts hash.
    # Similar to counts_hash, except containing the probability that a word
    # follows two preceding words (as opposed to number of occurrences).
    def self.counts_to_probs(counts_hash)
      probs_hash = {}
      counts_hash.each do |prev, cur_freq|
        probs_hash[prev] ||= {}
        cur_freq.each do |cur, freq|
          prob = freq.to_f / cur_freq.values.reduce(:+)
          probs_hash[prev][cur] = prob
        end
      end
      probs_hash
    end

    # Generates a sample word, given a probability hash.
    def self.sample_word(probs_hash)
      score = rand
      probs_hash.each do |word, prob|
        return word if score < prob
        score -= prob
      end
    end

    # Generates a sample sentence, given a probability hash.
    def self.sample_sentence(probs_hash)
      prev2 = nil
      prev1 = nil
      out = []

      while true
        cur = sample_word(probs_hash[[prev2, prev1]])
        if cur.nil?
          return out
        else
          out << cur
          prev2 = prev1
          prev1 = cur
        end
      end
    end

    # Generates a sentence from a probability hash.
    def self.sentence_from_probs_hash(probs, min_length)
      sent = []
      while score_sentence(sent, probs) > 30 || sent.length < min_length
        sent = sample_sentence(probs)
      end
      sent = sent[0..-2].join(" ") + "."
      sent
    end

    # Scores a sentence, depending on the likelihood that it occurs
    # within a corpus.
    def self.score_sentence(sent, probs)
      total_surprise = 0
      sent = [nil, nil] + sent + [nil]

      sent.zip(sent[1..-1], sent[2..-1]).each do |prev2, prev1, cur|
        total_surprise += -Math.log(probs[[prev2, prev1]][cur], 2)
      end
      total_surprise
    end
  end
end