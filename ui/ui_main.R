fluidPage(
  title = 'sHyMetDScompare',
  titlePanel('Cumulative sums'),
  sidebarLayout(
    sidebarPanel(
      
      h3("Climate Data-service vs. Observation"), 
      br(),
      shiny::includeMarkdown("md/cumu_desc.md"), hr(),
      dateInput("dt.cumu",label='select start date:'), hr(),
      htmlOutput("link.shyclimate"),
      
      # selectInput("sel.api", "Interpolation type:",
      #             c("Point interpolation (daily)" = "dymetp",
      #               "Catchment aggregated (daily)" = "dymetc",
      #               "Point interpolation (6-hourly)" = "h6metp",
      #               "Catchment aggregated (6-hourly)" = "h6metc")),
      # 
      # dateRangeInput("drng.main",label='select date range:'),
      # checkboxGroupInput("chkdat.main", "Choose data type:", choices=NULL),
      # downloadButton("csv.main", "Download data as csv"),
      # br(),br(),
      # shiny::includeMarkdown("md/leaflet.md"),
      # leafletOutput("map"),
      # # checkboxInput('chk.flg','show observation flags'),
      # # checkboxInput('chk.yld','show catchment simulation (where applied)'),
      
      width = 3
    ),
    mainPanel(
      
      plotOutput("gg.cumu", height="800px"), 
      br(),
      shiny::includeMarkdown("md/rightclick.md"),
      
      # tabsetPanel(type = "tabs",
      #             tabPanel("Viewer", 
      #                      shiny::includeMarkdown("md/dygraphnotes.md"),
      #                      dygraphOutput("dy.plt.raw"), 
      #                      br(),
      #                      column(6, plotOutput('plt.recent.1')),
      #                      column(6, plotOutput('plt.summary.1'))
      #             ),
      #             tabPanel("Printable", 
      #                      plotOutput("gg.plt.raw", height="800px"), 
      #                      br(),
      #                      shiny::includeMarkdown("md/rightclick.md")
      #             ),
      #             tabPanel("Summaries",
      #                      column(6, 
      #                             h3("Mean"),
      #                             formattableOutput('tab.summary.mean')),
      #                      column(6, 
      #                             h3("Median"),
      #                             formattableOutput('tab.summary.median')),
      #                      br(),
      #                      column(6, 
      #                             h3("5th percentile"),
      #                             formattableOutput('tab.summary.p5')),
      #                      column(6, 
      #                             h3("95th percentile"),
      #                             formattableOutput('tab.summary.p95'))
      #             )
      # ), 
      width = 9
    )
  )
)