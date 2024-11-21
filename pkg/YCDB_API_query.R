##########################################################
#################### YCDB querying ####################### 
##########################################################
# in support of sHyClimate
# Jan, 2024
##########################################################

data.api <- 'http://golang.oakridgeswater.ca:8080/'

###########################################################################################
## API addresses
###########################################################################################
ldbc <- paste0(data.api, 'locmet/')
idbc <- paste0(data.api, 'intgen/3/')

###########################################################################################
## collect locations
###########################################################################################
qLoc <- function(API){
  return(fromJSON(API))
}

###########################################################################################
## collect location info
###########################################################################################
qLocInfo <- function(API,LOC_ID){
  t1 <- qLoc(API)
  return(t1[t1$LOC_ID==LOC_ID,])
}


###########################################################################################
## temporal Query
###########################################################################################
qTemporal <- function(API,INT_ID){
  url <- paste0(API,INT_ID)
  print(url)
  return(buildDF(fromJSON(url)))
}

qTemporal_byLOC_ID <- function(lAPI,iAPI,LOC_ID){
  t1 <- qLoc(lAPI)
  return(qTemporal(iAPI,t1[t1$LOC_ID==LOC_ID,]$IID))
}

qTemporal_json <- function(fp) {
  df <- fromJSON(fp)
  print(unique(df$RDNC)) # unique RDNC
  return(buildDF(df))
}


###########################################################################################
## functions
###########################################################################################
buildDF <- function(df) {
  # df <- df[!(df$unit==35),] # removing snowfall
  df <- df[!(df$RDNC %in% xr.Ignore),!(names(df) %in% c('RDTC'))] %>% 
    distinct() %>%
    filter(!(RDNC==552 & unit == 21)) %>% # removing snow depth given in mm
    select(-unit)
  
  rdncs <- unique(df$RDNC)
  
  if ( length(rdncs)>1 ) {
    df.day <- df %>%
      spread(RDNC, Val) %>%
      mutate(Date = zoo::as.Date(Date)) %>%
      plyr::rename(xr.RNDC) %>%
      drop_na(Date)
      # complete(Date = seq.Date(min(Date),max(Date),by='day'))    
  } else {
    df.day <- df %>%
      mutate(Date = zoo::as.Date(Date)) %>%
      rename(!! paste(rdncs[1]) := Val) %>%
      select(-c(RDNC)) %>%
      plyr::rename(xr.RNDC) %>%
      drop_na(Date)
  }
  
  df.day.nozero <- df.day[, colSums(df.day != 0, na.rm = TRUE) > 0] # filter out occasional zero-only columns

  if (anyDuplicated(df.day.nozero$Date)) { # check for sub-daily data
    print(' qTemporal_json: sub-daily data detected')
    if ( length(rdncs)>1 ) {
      return(
        df %>% 
          spread(RDNC, Val) %>%
          mutate(Date = as.POSIXct(Date, format="%Y-%m-%dT%H:%M:%S")) %>%
          plyr::rename(xr.RNDC) %>%
          drop_na(Date)
        # complete(Date = seq.POSIXt(min(Date),max(Date),by='day'))
      )       
    } else {
      return(
        df %>% 
          mutate(Date = as.POSIXct(Date, format="%Y-%m-%dT%H:%M:%S")) %>%
          rename(!! paste(rdncs[1]) := Val) %>%
          select(-c(RDNC)) %>%
          plyr::rename(xr.RNDC) %>%
          drop_na(Date)       
      )   
    }
  } else {
    print(' qTemporal_json complete')
    return(df.day.nozero)
  }
}
        

observe({
  loc$lnk <- paste0('<a href="https://owrc.shinyapps.io/sHyMet/?sID=',loc$lid,'" target="_blank" rel="noopener noreferrer">open timeseries analysis tool</a>')
})   