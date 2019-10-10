library(shiny)
library(ggplot2)
library(dplyr)
library(ggmap)
volcano_data <- read.delim("https://www.ngdc.noaa.gov/nndc/struts/results?type_0=Exact&query_0=$HAZ_EVENT_ID&t=102557&s=50&d=54&dfn=volerup.txt")
volcano_data<-volcano_data[,c("Year","Name","Location","Country","Latitude","Longitude","Type")]

ui <- fluidPage( titlePanel(title="Volcanic Eruptions Map"),
                 sidebarLayout(sidebarPanel("Co-ordinates"),mainPanel(plotOutput("volcanoplot"))),
                 
   
                 
                 sliderInput("lat_slider", "lattitude", min = -90, max = 90,value = 63, pre = "Degree"),
                 sliderInput("long_slider", "longitude", min = -180, max = 180,value =-19, pre = "Degree"),
                
                 verbatimTextOutput("value")
                 )


server <- function(input, output){
  
                  output$volcanoplot<- renderPlot(
                                          
                                          get_stamenmap(c(left = input$long_slider-10 , bottom =input$lat_slider-10, right =input$long_slider+10, top =input$lat_slider+10), zoom = 5,maptype = "terrain") %>% ggmap()+geom_point(aes(x =volcano_data$Longitude, y =volcano_data$Latitude), data = volcano_data, colour = "red", size = 2)  
  
                    
                    )
}  
# Last line
shinyApp(ui = ui, server = server) 