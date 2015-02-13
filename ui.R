shinyUI(bootstrapPage(

  selectInput(inputId = "AverageHW",
      label = "Average of Your Two Homework Scores",
      choices = seq(0,50,by=1),
      selected = 35),
  
  selectInput(inputId = "ExamOne",
              label = "Your Exam One Score",
              choices = seq(0,100,by=1),
              selected = 80),

  plotOutput(outputId = "main_plot", height = "300px"),
  
    textOutput("text1")

))