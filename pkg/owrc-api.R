
owrc.api.fews <- 'http://fews.oakridgeswater.ca:8080/' #'https://fews.oakridgeswater.ca/'


owrc.api <- function(lat,lng,opt='dymetp') {
  # collect data
  url <- paste0(owrc.api.fews, opt,'/',lat,'/',lng)
  print(url)
  showNotification("interpolating..",type="message")
  df <- jsonlite::fromJSON(url)
  if ( !is.data.frame(df) ) { # ( df=="NA" ) { #
    # showNotification("clicked location outside of region",type="warning")
    return(FALSE)
  }
  df[df == -999] <- NA # do this before converting date
  loc$df <- merge(loc$df,df,by='Date') %>% drop_na()
  
  return(TRUE)
}
