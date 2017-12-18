#' ---
#' title: "R skeleton for scripts which can produce HTML output"
#' subtitle: "Rendered using `rmarkdown::render`"
#' author: "Lorenzo Gaborini"
#' date: ""
#' output: 
#'   html_document:
#'     toc: true
#'     theme: flatly
#'     toc_float: 
#'       collapsed: false
#'     self_contained: false
#'     code_folding: show
#' ---
#' \providecommand{\simiid}{~\overset{iid}{\sim}~}
#' 
#+ setup, include=FALSE

rm(list = ls())

# Options for knitr

# Remove knitr progressbar
knitr::opts_knit$set(progress = FALSE)

# Enable knitr cache
knitr::opts_chunk$set(cache = TRUE, 
                      clean = FALSE, 
                      autodep = TRUE, 
                      cache.comments = TRUE,
                      cache.path = 'knitr_cache/',
                      fig.path = 'knitr_fig/')
# Clear knitr cache
# knitr::opts_chunk$set(cache.rebuild = TRUE)

#' # Title
#' 
#' This script can be run within base R, and can be rendered to HTML using `rmarkdown::render("R_rmarkdown_template.R")`.
#' 
#' # Code
#+ code
head(iris)

#' ## Subsection
head(iris)