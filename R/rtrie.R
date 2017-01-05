# rtrie
# TODO parallelize
# TODO: Replace the evaluate_str function - future PR
# TODO - compare / contrast with other trie/tree packages

#'
#' evaluate_str
#'
#' @export
#' @param str A character string
#' @param trie A trie representing a list of words
#' @return The list evaluated.
#' @examples
#' trie <- char_tree(c('able', 'act', 'acts', 'across','act',
#'                     'bat','babble','bobble'), 'X')
#' evaluate_str('acts',trie)
#'
evaluate_str <- function(str, trie){
  str_path<- paste(unlist(strsplit(str,"")), collapse = "$")
  eval(parse(text=paste0(deparse(substitute(trie)),'$',str_path)))
}


#' Create a new trie
#'
#' Create a trie from a vector of words passed as an argument.
#' Based on Florent Delmotte's response on http://stackoverflow.com/questions/27060453/how-to-build-an-alphabetical-tree-from-a-list-of-words-in-r.
#'
#' @export
#' @param words Vector of words.
#' @param end Terminating character.  Default is NULL.
#' @return a trie (list of lists)
#' @examples
#' char_tree(c('able', 'act', 'acts', 'across',
#'             'act','bat','babble','bobble'), 'X')
#'
char_tree <- function(words, end = NULL) {
  first <- substr(words, 1, 1)
  rest  <- substr(words, 2, nchar(words))
  zi    <- nchar(words) == 0L
  c(list(end)[any(zi)],
    lapply(split(rest[!zi], first[!zi]), char_tree, end = end))
}

#' Matching words
#'
#' Return a list of words that match a string passed as an argument.
#' The match is anchored to the beginning of the string, so that words
#' that start with the string "str" are returned.
#'
#' @export
#' @param str A character string that will be compared with the trie.
#' @param trie A trie representing a list of words that will be searched.
#' @return A vector of words represented in the trie that match the character string passed in as an argument.
#' @examples
#' trie <- char_tree(c('able', 'act', 'acts', 'across','act',
#'                     'bat','babble','bobble'), 'X')
#' matching_words('act',trie)
#'
matching_words <- function(str, trie){
  tmp<-names(!is.null(unlist(evaluate_str(str, trie))) &
               unlist(evaluate_str(str, trie))=='X')
  sapply(tmp,function(x) paste0(str, gsub('\\.','',x)))
}


#' Is a word
#'
#' Verify whether or not a given string is a word in the trie
#'
#' @export
#' @param str A character string that may or may not be a word in the trie.
#' @param trie The trie to search.
#' @return a Boolean
#' @examples
#' trie <- char_tree(c('able', 'act', 'acts', 'across','act',
#'                     'bat','babble','bobble'), 'X')
#' is_word('tree', trie)
#'
is_word <- function(str, trie){
  str %in% matching_words(str, trie)
}
