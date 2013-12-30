# Markovfun

This gem generates sentences from textfiles using trigrams.
It is based on Alex Rudnick's Python Markov chain generator,
the code for which is (here)[https://github.com/alexrudnick/hackerschool-demos/tree/master/ngrams].

## Installation

Add this line to your application's Gemfile:

    gem 'markovfun'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markovfun

## Usage

Here's how you can generate a sentence from a text file.

sentences = Markovfun.get_sentences("bible.txt")
counts = Markovfun.get_counts(sentences)
probs = Markovfun.counts_to_probs(counts)
Markovfun.sentence_from_probs_hash(probs)
