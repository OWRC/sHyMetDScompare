

loc <<- reactiveValues(lid=NULL, iid=NULL, name=NULL, name2=NULL, df=NULL, 
                      DTb=NULL, DTe=NULL, lat=NULL, lng=NULL, label=NULL, 
                      info.html=NULL)


##############################################################
### collect data from API
##############################################################
collect_temporal <- function(LOC_ID) {
  isolate(withProgress(message = 'collecting station info..', value = 0.1, {
    loc$lid <- LOC_ID
    info <- qLocInfo(ldbc,loc$lid)
    if (nrow(info)<=0) showNotification(paste0("Error LOC_ID: ",loc$lid," not found."))
    loc$iid <- info$INT_ID
    loc$lat <- info$LAT
    loc$lng <- info$LONG
    loc$name <- info$LOC_NAME_ALT1
    loc$name2 <- info$LOC_NAME
    loc$label <- paste0(loc$name,': ',loc$name2)
    setProgress(message = 'collecting station data..',value=0.35)
    loc$df <- qTemporal(idbc,loc$iid)
    print(paste0("LOC_ID: ",loc$lid,"; INT_ID: ",loc$iid,"; ",loc$label))
    if (nrow(loc$df)<=0) showNotification(paste0("Error no data found for ",loc$name2))
    setProgress(message = 'rendering plot..',value=0.9)
    loc$DTb <- min(loc$df$Date, na.rm=T)
    loc$DTe <- max(loc$df$Date, na.rm=T)
    print(colnames(loc$df))
    nam <- unname(xr.NLong[colnames(loc$df)[-1]])
    stat <- colMeans(loc$df[-1], na.rm = TRUE)*(xr.step[xr.Nshrt[nam]]*364.24+1)
    ndat <- sum(!is.na(loc$df[2]))-1
    # loc$info <- loc.info(loc$label,ndat,min(loc$df$Date,na.rm=T),max(loc$df$Date,na.rm=T),stat,nam)
    loc$info.html <- loc.info.html(loc$label,ndat,min(loc$df$Date,na.rm=T),max(loc$df$Date,na.rm=T),stat,nam)
    owrc.api(info$LAT,info$LONG)
  }))
  print("collect_temporal complete")
  shinyjs::hide(id = "loading-content", anim = TRUE, animType = "fade")
  shinyjs::show("app-content")
}

collect_temporal_json <- function(fp) {
  isolate(withProgress(message = 'collecting station info..', value = 0.1, {
    loc$lid <- -1
    loc$iid <- -1
    loc$name <- 'test'
    loc$name2 <- paste0('from csv: ',fp)
    loc$label <- paste0(loc$name,': ',loc$name2)
    loc$df <- qTemporal_json(fp)
    loc$DTb <- min(loc$df$Date, na.rm=T)
    loc$DTe <- max(loc$df$Date, na.rm=T)

    nam <- unname(xr.NLong[colnames(loc$df)[-1]])
    stat <- colMeans(loc$df[-1], na.rm = TRUE)*(xr.step[xr.Nshrt[nam]]*364.24+1)
    ndat <- sum(!is.na(loc$df[2]))-1
    loc$info.html <- loc.info.html(loc$label,ndat,loc$DTb,loc$DTe,stat,nam)
  }))
  shinyjs::hide(id = "loading-content", anim = TRUE, animType = "fade")
  shinyjs::show("app-content")
  print(" collect_temporal_json complete")
}


print('collect_temporal.R loaded')