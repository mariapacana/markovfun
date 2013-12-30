# Markovfun

This gem generates sentences from textfiles using trigrams (and eventually will do the same for bigrams).
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

Generate a sentence with a specified min length (in this case, 4) from the probability hash.

`sentence = Markovfun::Trigram.sentence_from_probs_hash(probs, 4)`

Score the sentence by "surprisal value" given a probability hash.

`Markovfun::Trigram.score_sentence(sentence, probs)`

### Sample Program

Here's how you can generate a sentence from a text file.

```
sentences = Markovfun::Util.get_sentences("bible.txt")
counts = Markovfun::Trigram.get_counts(sentences)
probs = Markovfun::Trigram.counts_to_probs(counts)
Markovfun::Trigram.sentence_from_probs_hash(probs, 4)
```

### Sample Sentence!

From "The Beautiful and the Damned":
"I liked him tremendously--ah, she had enjoyed a rather romantic figure, a scholar, a recluse, a tower of erudition."
