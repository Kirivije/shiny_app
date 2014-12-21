library(shiny)

# Define UI for application that draws a histogram

shinyUI(fluidPage(
        
        # Application title
        headerPanel("DNA variation viewer"),
        
        # Sidebar with controls to select the random distribution type
        # and number of observations to generate. Note the use of the br()
        # element to introduce extra vertical spacing
        sidebarPanel(
                sliderInput("snp", 
                            "SNP threshold:", 
                            
                            min = 1, 
                            max = 1000 ,
                            value = 6),               
                
                br(),
                br(),
                
                textInput("window", "Window size:", "100000"),
                submitButton("Submit")
                
                
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
                tabsetPanel(
                        tabPanel("Introduction", includeMarkdown("intro.Rmd")),
                        tabPanel("Plot", plotOutput("distPlot")), 
                        tabPanel("SNP summary", verbatimTextOutput("summary"))
                        
                )
        )
))

