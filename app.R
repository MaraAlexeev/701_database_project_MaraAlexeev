
ui <- fluidPage(

    mainPanel(
        tabsetPanel(
            tabPanel(title = h2("Get Recipes with SQL"),
                     hr(),
                     br(),
                     h4("Query Recipes with SQL"),
                     textAreaInput("sql_input1",
                               "SQL Query:",
                               "SELECT * FROM recipe_meta WHERE recipe_id < 10"),
                     tableOutput("tbl")
                     ),

            tabPanel(h2("Table Info"),
                     verbatimTextOutput("summary"),
                     img(src='db_layout.png', align = "center")),



            tabPanel(
                title = h2("Enter Recipes Simple"),
                # form fields
                textInput(inputId = "recipe_name_simple", label = "Name of Recipe"),
                textAreaInput(inputId = "raw_recipe_ingredients", label = "Paste recipe ingredients here",
                              width = "1000px",
                              height = "250px"),

                textAreaInput(inputId = "raw_recipe_steps", label = "Paste recipe directions here",
                              width = "1000px",
                              height = "250px"),
                br(),
                actionButton(inputId = "submitBtn", label = "Submit")

                ),

            tabPanel(
                title = h2("Enter Recipes All Options"),
                # form fields
                textInput(inputId = "recipe_name", label = "Recipe Name"),
                textInput(inputId = "attribution_name", label = "R"),
                br(),
                actionButton(inputId = "submitBtn", label = "Submit")

            )
            ))
        )


server <- function(input, output, session) {
    output$tbl <- renderTable({
        con_recipe_db
        query <- input$sql_input1
        dbGetQuery(con_recipe_db, query)
    })
}

shinyApp(ui, server)
