library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Hello Shiny!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(

      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      tags$iframe(src="https://www.instagram.com/p/CeYRgo_NLUJ/embed", height=600, width=535)
      
    )
  )
)




# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)
