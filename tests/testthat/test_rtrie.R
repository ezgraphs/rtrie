context("Testing trie generation")
set.seed(1)

test_that("The char_tree method correctly creates a trie", {
  trie <- char_tree(c('able', 'act', 'acts', 'across','act','bat','babble','bobble'), 'X')
  expect_equal(2, length(trie))
  expect_equal(7, length(unlist(trie)))
  expect_equal(4, length(unlist(trie$a)))
  expect_equal(3, length(unlist(trie$a$c)))
  expect_equal(2, length(unlist(trie$a$c$t)))
  expect_equal(1, length(unlist(trie$a$c$t$s)))
  expect_equal(0, length(unlist(trie$a$c$t$s$z)))
  expect_equal(0, length(unlist(trie$z)))
})

test_that("The is_word method correctly identifies words", {
  trie <- char_tree(c('able', 'act', 'acts', 'across','act','bat','babble','bobble'), 'X')
  expect_true(is_word('act', trie))
  expect_true(is_word('acts', trie))
  expect_false(FALSE, is_word('actsx', trie))
  expect_false(FALSE, is_word('ac', trie))
})

test_that("The expect_match method correctly matches words", {
  trie <- char_tree(c('able', 'act', 'acts', 'across','act','bat','babble','bobble'), 'X')
  expect_equivalent(c('act','acts'), matching_words('act',trie))
  expect_equivalent(c('across','act','acts'),
                    matching_words('ac',trie))
})

test_that("The expect_match method correctly matches words", {

  words<-read.delim(
    file=system.file("extdata", "dictionary.txt", package = "rtrie"),
    header=F, sep = " ",
    stringsAsFactors = FALSE)
  # Takes ~ 11 seconds to create a list of 80,000 words
  trie2 <- char_tree(words$V1, 'X')
  expect_equivalent(c('scatted','scatter','scatters'),
                    matching_words('scatte',trie2))
})

