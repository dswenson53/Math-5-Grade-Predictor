shinyServer(function(input, output) {

  library(class)
  
  AvgHW = c(31,38,38,32.5,37,35.5,37.5,34.5,23.5,33,39,47,49.5,50,49.5,41.0,45.0,41.5,43.0,45.0,47.0,49.5,49.5,38.5,49.0)
  
  ExamOne = c(59,64,60,71,87,52,24,86,56,56,69,78,64,91,66,54,81,67,83,91,74,81,76,46,91)
  
  Status = factor(c(0,1,0,1,2,0,0,1,0,0,1,2,2,2,1,0,2,0,2,2,2,1,2,0,2))
  
  output$main_plot <- renderPlot({

    plot(AvgHW,ExamOne,xlab="Average of First Two Homework Scores",ylab="Exam One Score",main="Math 5 Grades",xlim=c(0,50),ylim=c(0,100),bty="n",cex.main=2)
    legend("left", c("\"A\" or \"B\"","\"C\"","\"D\" or \"F\"","You"), pch = 21, title = "Legend",col=c("green","yellow","red","black"),pt.bg=c("green","yellow","red","black"),inset = .025,cex=1.5)
    for (i in 1:length(Status)) {
      if (Status[i] == 0) {
        points(AvgHW[i],ExamOne[i],col="red",bg="red",pch=21,lwd=3,cex=2)
      }
      if (Status[i] == 1) {
        points(AvgHW[i],ExamOne[i],col="yellow",bg="yellow",pch=21,lwd=3,cex=2)
      }
      if (Status[i] == 2) {
        points(AvgHW[i],ExamOne[i],col="green",bg="green",pch=21,lwd=3,cex=2)
      }
    }
    points(input$AverageHW,input$ExamOne,pch=21,cex=2,lwd=3,col="black",bg="black")

    result = knn(k=3,train=cbind(AvgHW,ExamOne),test=cbind(input$AverageHW,input$ExamOne),cl=Status)
    
    if (result == 2) {
      output$text1 <- renderText({ 
        "You are on track to receive an \"A\" or a \"B\" in the course."
      })
    }
    if (result == 1) {
      output$text1 <- renderText({ 
        "You are on track to receive a \"C\" in the course."
      })
    }
    if (result == 0) {
      output$text1 <- renderText({ 
        "You are on track to receive a \"D\" or an \"F\" in the course."
      })
    }
    
    
  })
  

  
})