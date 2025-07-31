###############################################################
####################### sHyMetDScompare #######################
#### A Shiny-Leaflet interface for time series analysis.  #####
###############################################################
# Analysis tool to compare interpolated climate data service
# with location data
#
# By M. Marchildon
# v.1.0
# Dec, 2024
###############################################################


for (f in list.files("pkg", pattern="*.R", recursive = TRUE, full.names = TRUE)) {source(f, local = TRUE)}

ggres <<- 128

shinyApp(
  ui <- fluidPage(
    useShinyjs(),
    tags$head(includeCSS("pkg/styles.css")),
    inlineCSS(appLoad),
    
    # Loading message
    div(
      id = "loading-content",
      div(class='space300'),
      h2("Loading..."),
      div(img(src='ORMGP_logo_no_text_bw_small.png')), br(),
      shiny::img(src='loading_bar_rev.gif')
    ),
    
    # The main app
    hidden(
      div(
        id = "app-content",
        list(tags$head(HTML('<link rel="icon", href="favicon.png",type="image/png" />'))),
        div(style="padding: 1px 0px; height: 0px", titlePanel(title="", windowTitle="sHyMetDScompare")), # height: 0px
        source(file.path("ui", "ui_main.R"), local = TRUE)$value
      )
    )
  ),
  
  server <- function(input, output, session){
    ###################
    ### Parameters & methods:
    for (f in list.files("srv", pattern="*.R", recursive = TRUE, full.names = TRUE)) {source(f, local = TRUE)}
    
    ###################
    ### collect data:
    # collect_temporal(148690) #(360000048) #(148945) #(730900042) #
    observe({
      query <- parseQueryString(session$clientData$url_search)
      if (!is.null(query[['iid']])) {
        collect_temporal(query[['iid']])
      } else {
        showNotification(paste0("Error: URL invalid."))
      }
    })
    
    session$onSessionEnded(stopApp)
  }
)
