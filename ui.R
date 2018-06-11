library(shiny)
library(shinydashboard)
library(proxy)
library(recommenderlab)
library(reshape2)
library(plyr)
library(dplyr)
library(DT)
library(RCurl)


movie = read.csv("movies.csv", header = TRUE, stringsAsFactors = FALSE)
movies = movie[with(movie, order(title)), ]
rating = read.csv("m.csv", header = TRUE)

shinyUI(dashboardPage(skin="black",
                      dashboardHeader(title = "MOVIErec"),
                      dashboardSidebar(
                        sidebarMenu(
                          menuItem("Movies", tabName = "movies", icon = icon("star-o")),
                          menuItem("About", tabName = "about", icon = icon("question-circle")),
                          menuItem("Work", icon = icon("file-code-o"), href = "http://ppt.cc/RTzOO"),
                          menuItem( 
                            list(      selectInput("select1", label = h5("GENDER"),
                                                   choices = as.character(c("M","F")),
                                                   selectize = FALSE,
                                                   selected = "None"),
                                       selectInput("select2", label = h5("GENRE"),
                                                   choices = as.character(unique(movie$genre1[1:length(unique(movie$movieId))])),
                                                   selectize = FALSE,
                                                   selected = "18"),
                                       selectInput("select3", label = h5("RATING"),
                                                   choices = as.character(c(0.5,1,1.5,2,2.5,3,3.5,4,4.5,5)),
                                                   selectize = FALSE,
                                                   selected = "Allen"),
                                       submitButton("Submit")
                            )
                          )
                        )
                      ),
                      
                      dashboardBody(
                        tags$head(
                          tags$style(type="text/css", "select { max-width: 720px; }"),
                          tags$style(type="text/css", ".span4 { max-width: 720px; }"),
                          tags$style(type="text/css",  ".well { max-width: 720px; }")
                        ),
                        
                      tabItems(  
                        tabItem(tabName = "about",
                                  h2("About this App"),
                                  
                                  HTML('<br/>'),
                                  
                                  fluidRow(
                                    box(title = "Author: ARUSHI CHAUHAN and VAISHALI AGGARWAL", background = "navy", width=12, collapsible = TRUE,
                                        
                                        helpText(p(strong("This application a movie reccommender using the movielense dataset."))),
                                        
                                        helpText(p("Please contact us on ",
                                                   a(href ="http://ppt.cc/RTzOO", "Facebook",target = "_blank"),
                                                   " or at my",
                                                   a(href ="https://github.com/arushichauhan", "Github", target = "_blank"),
                                                   ", for more details and suggest improvements or report errors.")),
                                        
                                        helpText(p("All source code and data is available at ",
                                                   a(href ="https://github.com/arushichauhan", "my GitHub page",target = "_blank"),
                                                   "or git from my Github."
                                                )),   
                                        
                                        helpText(p("Special Thanks for NIEC CSE DEPARTMENT",
                                                 a(href ="https://github.com/arushichauhan",  target = "_blank"),
                                                 "."))
                                        
                                    )
                                  )
                          ) 
                      ),    
                      tabItem(tabName = "movies",
                              fluidRow(
                                fluidRow(
                                  
                                  infoBoxOutput("progressBox1"),
                                  infoBoxOutput("approvalBox2"),
                                  infoBoxOutput("approvalBox3"),
                                  box(
                                    width = 6, status = "info", solidHead = TRUE,
                                    title = "Movies Recommended To You",
                                    tableOutput("table")
                                    ),                                  
                                  a(img(src="Film.png",height=400,width=450), href="https://en.wikipedia.org/wiki/Suicide_Squad_(film)"),

                                  HTML('<br/>'),
                                  a(img(src="1.jpg",height=200,width=150), href="https://en.wikipedia.org/wiki/Suicide_Squad_(film)"),
                                  a(img(src="2.jpg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Avengers_(2012_film)"),
                                  a(img(src="3.jpg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Godfather"),
                                  a(img(src="4.jpeg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Shawshank_Redemption"),
                                  a(img(src="5.jpeg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Shawshank_Redemption"),
                                  a(img(src="6.jpg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Shawshank_Redemption"),
                                  a(img(src="7.jpeg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Shawshank_Redemption"),
                                  a(img(src="8.jpg",height=200,width=150), href="https://en.wikipedia.org/wiki/The_Shawshank_Redemption"),
                                  
                                  HTML('<br/>'),
                                  
                                  box(DT::dataTableOutput("myTable"), title = "All Movies We Have", width=12, collapsible = TRUE)
                 
                    
                                
                                  
                                )
                              )
                                
                              )
                      )
                  )
)                         
