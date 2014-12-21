sample <- read.delim("data/snp_pos.bed")
sample$snp <- 1
library(shiny)
library(ggplot2)
library(Hmisc)


shinyServer(function(input, output) {
      
        output$distPlot <- renderPlot({
                
                
                ch06_2 <- aggregate(sample$snp, 
                                    list(cut2(sample$chromStart, 
                                             cuts=seq(min(sample$chromStart), max(sample$chromStart), 
                                                        by = as.numeric(input$window)
                                             ))),
                                    FUN = "sum")
                
                ch06_3 <- ch06_2[ch06_2$x > input$snp, ]
                
        
                
                snpDensity_3 <-ggplot(ch06_3, aes(x = Group.1, y = x)) + 
                        geom_bar(stat="identity") + 
                        ggtitle("SNP density of across chromosome") +
                        xlab("Position in the chromosome") + 
                        ylab("SNP density") + 
                        theme(axis.text.x=element_text(angle=90, colour = "blue", size=8)) +
                        theme(axis.text.y=element_text(size=10, colour = "black")) +
                        coord_cartesian(ylim=c(input$snp, max(ch06_3$x)))
                
                
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
                final_stat <- summary(data.frame(ch06_3$x))
                colnames(final_stat) <- "summary statistic"
                print(final_stat)
        })
})