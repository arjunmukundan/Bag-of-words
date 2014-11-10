library(shiny)
library(shinyIncubator)
 
shinyServer(function(input, output, session) {
  terms <- reactive({
    input$update
    isolate({
      withProgress(session, {
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  wordcloud_rep <- repeatable(wordcloud)
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max, rot.per = 0,
                  colors = palette(c("#A5C5AF", "#AA7570", "#3D4048"))
)
  })
})
