sample <- read.delim("data/snp_pos.bed")
sample$snp <- 1
library(shiny)
library(ggplot2)
library(Hmisc)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        # Expression that generates a histogram. The expression is
        # wrapped in a call to renderPlot to indicate that:
        #
        #  1) It is "reactive" and therefore should re-execute automatically
        #     when inputs change
        #  2) Its output type is a plot
        
        output$distPlot <- renderPlot({
                #bins <- seq(min(ch06$START), max(ch06$START), length.out = input$bins + 1)
                #read your file
                
                ch06_2 <- aggregate(sample$snp, 
                                    list(cut2(sample$chromStart, 
                                             cuts=seq(min(sample$chromStart), max(sample$chromStart), 
                                                        by = as.numeric(input$window)
                                             ))),
                                    FUN = "sum")
                
                ch06_3 <- ch06_2[ch06_2$x > input$snp, ]
                
        
                
                snpDensity_3 <-ggplot(ch06_3, aes(x = Group.1, y = x)) + 
                        geom_bar(stat="identity") + # pick a binwidth that is not too small 
                        ggtitle("Density of accross chromosomes") +
                        xlab("Position in the genome") + 
                        ylab("SNP density") + 
                        theme(axis.text.x=element_text(angle=90, colour = "red", size=8)) +
                        theme(axis.text.y=element_text(size=10, colour = "black"))  #black and white background
                print(snpDensity_3)
        })
        
        output$summary <- renderPrint({
                ch06_2 <- aggregate(sample$snp, 
                                    list(cut(sample$chromStart, 
                                             breaks=seq(min(sample$chromStart), max(sample$chromStart), 
                                                        by =as.numeric(input$window)
                                             ))),
                                    FUN = "sum")
                ch06_3 <- ch06_2[ch06_2$x > input$snp, ]
                summary(data.frame(ch06_3$x))
        })
})