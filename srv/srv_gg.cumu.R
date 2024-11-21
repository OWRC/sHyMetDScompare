

observe({
  updateDateInput(session, "dt.cumu",
                  value = min(loc$df$Date),
                  min = min(loc$df$Date,na.rm=TRUE),
                  max = max(loc$df$Date,na.rm=TRUE))
})

output$gg.cumu <- renderPlot({
  req(dtb <- input$dt.cumu)
  
  if (!is.null(loc$df)) {
    df <- loc$df %>% filter(Date>dtb) %>% mutate(Date=as.Date(Date),yield=Rf+Sm) %>%
      complete(Date = seq.Date(min(Date,na.rm=TRUE), max(Date,na.rm=TRUE), by="day")) %>%
      replace_na(list(Precip=mean(loc$df$Precip,na.rm=TRUE),yield=mean(loc$df$Rf,na.rm=TRUE)+mean(loc$df$Sm,na.rm=TRUE))) %>%
      mutate(observed=cumsum(Precip), interpolated=cumsum(yield), infil=is.na(Rf))
    
    # df <- data.frame(Date=df$Date, observed=cumsum(df$Precip), interpolated=cumsum(df$yield), infil=is.na(df$Rf))
    # View(df)
    
    # blank-out infilled data
    df$observed[df$infil] = NA
    df$interpolated[df$infil] = NA
    
    
    ggplot(df, aes(Date)) +
      theme_bw() + theme(legend.position=c(.9,.15),
                         legend.title = element_blank()) +
      geom_vline(xintercept = as.numeric(as.Date("2002-01-01")), linetype='dotted') +
      geom_vline(xintercept = as.numeric(as.Date("2009-12-09")), linetype='dotted') +
      geom_point(aes(y=observed, color="observed"), size=1) +
      geom_point(aes(y=interpolated, color="interpolated"), size=1) +
      annotate("text",x=as.Date("2002-01-01"),y=0,label = "CaPA-RDPA begins",hjust = 0) +
      annotate("text",x=as.Date("2009-12-09"),y=0,label = "SNODAS begins",hjust = 0) +
      labs(title=loc$label, y='Cumulative precipitation (mm)') +
      xlim(c(dtb,max(loc$df$Date,na.rm=TRUE)))
      # scale_x_date()
    
    
    # loc$df %>%
    # mutate(yield=Rf+Sm,year=year(Date)) %>%
    # ggplot(aes(Precip,yield)) +
    # geom_point(stat = "ecdf")  
    
    # loc$df %>%
    # mutate(yield=Rf+Sm,year=year(Date)) %>%
    # ggplot(aes(Precip,yield,colour=year)) +
    # geom_point() +
    # scale_color_continuous(type = "viridis")
  }
}, res=ggres)
