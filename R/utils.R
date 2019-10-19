rbind_data <- function(x, y){
  list(
    nodes = rbind(x$nodes, y$nodes),
    edges = rbind(x$edges, y$edges)
  )
}

get_last_id <- function(data) {
  data$nodes$id[nrow(data$nodes)]
}

new_node <- function(id, block_type = "standard", code = substitute(), code_str = ""){
  node <- data.frame(id, block_type, code_str, stringsAsFactors = FALSE)
  node$code <- list(code)
  node
}

new_edge <- function(to, from = to-1L, edge_label = "", arrow = "->"){
  data.frame(from , to, edge_label, arrow, stringsAsFactors = FALSE)
}

add_node <- function(data, node){
  data$node <- rbind(data$node, node)
  data
}

add_edge <- function(data, node){
  data$edge <- rbind(data$edge, node)
  data
}


rleid <- function(x){
  with(rle(x), rep(seq_along(lengths), lengths))
}

deparse2 <- function(x){
  x <- as.call(c(quote(`{`),x))
  x <- deparse(x)
  #if (x[1] == "{"){
  x <- x[-c(1, length(x))]
  x <- sub("^    ","",x)
  #}
  paste(x, collapse= "\n")
}

# controlflow ops with the addition of `#()` used to spot special comments
control_flow_ops <- c("if", "for", "while", "repeat", "#")

is_cfc_call <- function(x){
  is.call(x) && as.character(x[[1]]) %in% control_flow_ops
}

`%call_in%` <- function(calls, constructs){
  sapply(as.list(calls), function(x)
    is.call(x) && as.character(x[[1]]) %in% constructs)
}


block_type <- function(x) {
  attr(blocks[[i]], "block_type")
}

new_data <- function(){
  data <- list(
    nodes = data.frame(
      id=integer(0),
      block_type =character(0),
      stringsAsFactors = FALSE),
    edges = data.frame(
      from =integer(0),
      to = integer(0),
      edge_label = character(0))
  )
  data$nodes$code <- list()
  data
}