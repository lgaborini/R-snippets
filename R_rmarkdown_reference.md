---
title: "rmarkdown::render snippets"
subtitle: "R code snippets for scripts enhanced with rmarkdown `#'` markup"
author: "Lorenzo Gaborini"
date: ""
output: 
  html_document:
    toc: true
    toc_float: 
      collapsed: false
    self_contained: true
    keep_md: true
---
\newcommand{\tuple}[1]{\langle #1 \rangle}



# Setup chunk options



```r
library(knitr)
```

Remove knitr progressbar during page build:


```r
knitr::opts_knit$set(progress = FALSE)
```

Enable knitr cache:


```r
knitr::opts_chunk$set(cache = TRUE, 
                      clean = FALSE, 
                      autodep = TRUE, 
                      cache.comments = FALSE,
                      cache.path = 'cache/')
```

Clear knitr cache:


```r
knitr::opts_chunk$set(cache.rebuild = TRUE)
```

Auto pretty print:


```r
library(printr)
```

# Chunks without R comments

rmarkdown::render supports echoing R code used to build a chunks.  
R comments can be suppressed in echoed code using chunk option `tidy`.

## Within global options

Change all chunks in the current document:



```r
knitr::opts_chunk$set(tidy = TRUE, tidy.opts = list(comment = FALSE))
```

## Using a chunk template

Change only selected chunks.

Within global options, we can specify a chunk template:


```r
knitr::opts_template$set(nocomments = list(tidy = TRUE, tidy.opts = list(comment = FALSE)))
```

Template usage: set `opts.label` for a new chunk  
`#+ opts.label="nocomments"`

## Results

Without template:


```r
choose.method <- 'ML'
# choose.method <- 'fixed'
# choose.method <- 'exact'
```

With template:



```r
choose.method <- "ML"
```

# pandoc markdown extensions are supported

## TeX's `newcommand`  

Set just after YAML header!

`\newcommand{\tuple}[1]{\langle #1 \rangle}`  

`$\tuple{a, b, c}$` inserts: $\tuple{a, b, c}$

# R matrices to $\LaTeX$

This function converts an R matrix to LaTeX inline code:


```r
bmatrix <- function(x, digits = NULL, display = TRUE, pre = '', post = '', ...) {
   library(xtable)
   default_args = list(
      include.colnames = FALSE,
      only.contents = TRUE,
      include.rownames = FALSE,
      hline.after = NULL,
      comment = FALSE,
      print.results = FALSE
   )
   passed_args = list(...)
   calling_args = c(list(x = xtable(x, digits = digits)),
                    c(passed_args,
                      default_args[setdiff(names(default_args), names(passed_args))]))
   if (display){
      pre.tag <- '$$'
      post.tag <- '$$'
   } else {
      pre.tag <- ''
      post.tag <- ''
   }

   return(cat(
      pre.tag,
      pre,
      "\\begin{bmatrix}\n",
      do.call(print.xtable, calling_args),
      "\\end{bmatrix}",
      post,
      post.tag
   ))
}
```

The call:  
must use chunk option `results='asis'`


```r
bmatrix(diag(2))
```

$$  \begin{bmatrix}
  1.00 & 0.00 \\ 
  0.00 & 1.00 \\ 
   \end{bmatrix}  $$

## Adding a prefix to the line

### The wrong ways

With TeX prefix on separate line:  
$A =$

$$  \begin{bmatrix}
  1.00 & 0.00 \\ 
  0.00 & 1.00 \\ 
   \end{bmatrix}  $$

With TeX displaymath prefix on separate line:
$$A =$$

$$  \begin{bmatrix}
  1.00 & 0.00 \\ 
  0.00 & 1.00 \\ 
   \end{bmatrix}  $$

Inline equations
**not working**


Inline equations 2: 
inlinemath **not working**
$$

Inline equations 3: 
displaymath **not working**
$$$$

### The correct way

Using `bmatrix` with prefix, and `+results='asis'`:


```r
bmatrix(diag(2), pre='A =')
```

$$ A = \begin{bmatrix}
  1.00 & 0.00 \\ 
  0.00 & 1.00 \\ 
   \end{bmatrix}  $$

### Constant matrices

We can inline $\LaTeX$ constant matrices using pure $\LaTeX$ markup:

$$\mathbf{X} = \left[\begin{array}
{rrr}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{array}\right]
$$

# Totally ignore rmarkdown chunks

Just add C++ style comments:


```r
1
```

```
## [1] 1
```

Below, an ignored markdown line with R code:

Above, ignored markdown chunk:



```r
3
```

```
## [1] 3
```


---
title: "R_rmarkdown_reference.R"
author: "Lorenzo"
date: "Mon Dec 18 11:11:07 2017"
---
