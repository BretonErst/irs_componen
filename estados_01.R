library(tidyverse)
library(readxl)


da00 <- read_excel("IRS_entidades_mpios_2020.xlsx",
                   skip = 5, 
                   sheet = "Estados",
                   col_names = FALSE)












