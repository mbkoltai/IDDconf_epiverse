# epiverse project
# https://epiverse-trace.github.io/research-compendium/introduction.html

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### 
# dependencies
if (!require("remotes")) install.packages("remotes")
remotes::install_github("FRBCesab/rcompendium")
remotes::install_github("benmarwick/rrtools")

if(!require("pak")) install.packages("pak")

new <- c("gh",
         "usethis",
         "tidyverse",
         "here",
         "yaml",
         "renv")

pak::pak(new)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### 
# git setup
usethis::git_sitrep()

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### 

rcompendium::new_compendium()