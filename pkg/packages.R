

#######################
##### R Libraries #####
#######################
library(shiny)
library(dplyr)
library(plyr)
library(tidyr)
library(ggplot2)
library(shinyjs)
library(jsonlite)
library(zoo)
library(lubridate)
library(markdown)


#######################
### JavaScript code ###
#######################

### open page loading message
appLoad <- "
  #loading-content {
    position: absolute;
    background: #000000;
    opacity: 0.9;
    z-index: 100;
    left: 0;
    right: 0;
    height: 100%;
    text-align: center;
    color: #FFFFFF;
  }"