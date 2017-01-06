# rtrie

[![](http://cranlogs.r-pkg.org/badges/rtrie)](https://CRAN.R-project.org/package=rtrie)

## Description
This package is a super-simple [trie](https://www.cs.bu.edu/teaching/c/tree/trie/) implementation specifically geared for processing lists of words and quickly finding words that are in the word list, or sets of words that match the beginning of a given character string.  This type of processing is required when implementing auto-complete / word-suggestions or in word games like Scrabble or Boggle.

The latest release available from [CRAN](https://cran.r-project.org/web/packages/rtrie/index.html).  

## Sample Usage

At present, it is possible to create a trie, check if it contains a given word, or find words that start with a given chacter string.

```

library(rtrie)
trie <- char_tree(c('able', 'act', 'acts', 'across','act','bat','babble','bobble'), 'X')

cat(is_word('able',trie))
## TRUE

matching_words('act',trie)
## act acts

```

## More information

More examples of Usage in [vignette](https://cran.r-project.org/web/packages/rtrie/vignettes/trie_usage.html).
