

pltcol <- c("#ef8a62","#43a2ca")

xr.Ignore <- c(615,70752,70753,71025,71026,71207,71208,71209)

xr.RNDC <- c("546"="Tmax",
             "547"="Tmin",
             "548"="Tmean",
             "549"="Rain",
             "550"="Snow",
             "551"="Precip",
             "552"="PackDepth"#,
             # "71207"="modl.PackDepth",
             # "71208"="modl.PackSWE",
             # "71209"="modl.PackMelt"#,
             # "615"="Rad",
             # "70752"="Pan",
             # "70753"="Lake",
             # "71025"="WindSpeed",
             # "71026"="WindDir"
             )


xr.NLong <- c(
    "Precip"="Precipitation (mm)",
    "Tmax"="Daily max temperature (C)", 
    "Tmin"="Daily min temperature (C)",
    "Tmean"="Daily mean temperature (C)",
    "Rain"="Rainfall (mm)",
    "Snow"="Snowfall (mm)",
    "PackDepth"="Snowpack depth (cm)",
    "modl.PackDepth"="modelled Snowpack depth (cm)",
    "modl.PackSWE"="modelled Snowpack Water Equivalent (mm)",
    "modl.PackMelt"="modelled Snowpack Melt (mm)"#,
    # "Rad"="Global radiation (MJ/m2)",
    # "Pan"="Pan evaporation (mm)",
    # "Lake"="Lake evaporation (mm)",
    # "WindSpeed"="Wind speed (daily max gust, km/h)",
    # "WindDir"="Wind direction (max gust, &#8451 CCN)"
    )

fixlab <- function(s) {
  if(grepl("&#8451",s)) {
    return(gsub("&#8451","C",s))
  }else{
    return(s)
  }
}

xr.Nshrt <- setNames(names(xr.NLong), unname(xr.NLong)) #reverses above named list

xr.step <- c( # this can also be used to distiguish those values to be aggregated as a sum vs. an avg.
  "Precip"=TRUE,
  "Tmax"=FALSE, 
  "Tmin"=FALSE,
  "Tmean"=FALSE,
  "Rain"=TRUE,
  "Snow"=TRUE,
  "PackDepth"=FALSE,
  "modl.PackDepth"=FALSE,
  "modl.PackSWE"=FALSE,
  "modl.PackMelt"=FALSE#,
  # "Rad"=FALSE,
  # "Pan"=TRUE,
  # "Lake"=TRUE,
  # "WindSpeed"=TRUE,
  # "WindDir"=TRUE
  )