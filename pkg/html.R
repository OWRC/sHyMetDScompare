
########################################################
# hydrograph info
########################################################
loc.info.html <- function(title,ndat,DTb,DTe,stat,nam){
  por <- as.integer(difftime(DTe, DTb, units = "days"))
  a <- cbind(nam,round(stat,1))
  tb <- paste0(a[,1],'&emsp;', a[,2],'<br>', collapse = "")

  paste0(
    "<b>",title,"</b>", br(),

    'Period of Record: ',strftime(DTb, "%b %Y"),' to ',strftime(DTe, "%b %Y"),' (',por+1,' days)', br(), 
    'total missing: ',por-ndat,' days (',round((1-ndat/por)*100,0),'%)', br(), br(), 
    '<b>Annual averages:</b>', br(), tb
  )
}