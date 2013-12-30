# Markovfun

This gem generates sentences from textfiles using trigrams.
It is based on Alex Rudnick's Python Markov chain generator,
the code for which is [here](https://github.com/alexrudnick/hackerschool-demos/tree/master/ngrams).

## Installation

Add this line to your application's Gemfile:

    gem 'markovfun'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markovfun

## Usage

### File Processing

Get sentences from a text file:

`sentences = Markovfun::Util.get_sentences("bible.txt")`

### Trigrams

Create hash storing counts of words that follow two previous words.

`counts = Markovfun::Trigram.get_counts(sentences)`

Convert hash of counts to hash of probabilities.

`probs = Markovfun::Trigram.counts_to_probs(counts)`

Generate a sentence of minimum length 4 from the probability hash.

`sentence = Markovfun::Trigram.sentence_from_probs_hash(probs, 4)`

Score the sentence by "surprisal value"

`Markovfun::Trigram.score_sentence(sentence)`

### Sample Program

Here's how you can generate a sentence from a text file.

```
sentences = Markovfun.get_sentences("bible.txt")
counts = Markovfun.get_counts(sentences)
probs = Markovfun.counts_to_probs(counts)
Markovfun.sentence_from_probs_hash(probs, 4)
```
