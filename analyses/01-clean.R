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

### 
# Load packages
library(readxl)
library(tidyverse)

# Read raw data
dat <- readxl::read_xlsx("data/raw-data/linelist_20140701.xlsx")
##

# Clean raw data
dat_clean <- dat %>% 
  select(case_id,date_of_onset,date_of_outcome,outcome) %>% 
  mutate(across(.cols = c(date_of_onset,date_of_outcome),
                .fns = as.Date)) %>% 
  mutate(outcome = fct(outcome,level = c("Death","Recover"),na = "NA"))

# Write clean data
dat_clean %>% 
  write_rds("data/derived-data/linelist_clean.rds")

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### 
# Load packages
library(tidyverse)
library(incidence2)

# Read data
ebola_dat <- read_rds("data/derived-data/linelist_clean.rds")

# Create incidence2 object
ebola_onset <- 
  incidence2::incidence(
    x = ebola_dat,
    date_index = c("date_of_onset"),
    interval = "epiweek")

# Read incidence2 object
ebola_onset

# Plot incidence data
plot(ebola_onset)

# Write ggplot as figure
ggsave("figures/02-plot_incidence.png",height = 3,width = 5)

