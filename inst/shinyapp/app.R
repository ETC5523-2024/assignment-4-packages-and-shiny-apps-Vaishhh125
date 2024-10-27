# Load required libraries (include in the package dependencies instead of loading in the app)
library(shiny)
library(dplyr)

# Define the UI
ui <- fluidPage(
  titlePanel("AI and Automation Job Insights"),

  tags$head(
    tags$style(HTML("
      body {
        background-color: #f0f4f7;
        font-family: Arial, sans-serif;
        color: #333;
      }
      .panel {
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 15px;
      }
      h2 {
        color: #0056b3;
        text-align: center;
      }
      h3 {
        color: #0056b3;
      }
      h4 {
        color: #666;
      }
      table {
        width: 100%;
        border-collapse: collapse;
      }
      th, td {
        text-align: center;
        padding: 10px;
        border: 1px solid #e0e0e0;
      }
      th {
        background-color: #0056b3;
        color: white;
      }
      .btn-primary {
        background-color: #0056b3;
        border-color: #0056b3;
      }
      .btn-primary:hover {
        background-color: #004494;
        border-color: #004494;
      }
      .output-table {
        background-color: #e7f1ff;
        border-radius: 5px;
        padding: 10px;
      }
    "))
  ),

  sidebarLayout(
    sidebarPanel(
      h3("Filter Options"),
      selectInput("Industry", "Select Industry:", choices = c("All", unique(AIriskjobs$Industry))),
      selectInput("Company_Size", "Select Company Size:", choices = c("All", unique(AIriskjobs$Company_Size))),
      actionButton("clear_filters", "Clear Filters"),
      br(), br(),
      h4("Description of Fields:"),
      p("Industry: The sector to which the job belongs."),
      p("Company Size: Size of the company (small, medium, large)."),
      br(),
      h4("Interpretation of Outputs:"),
      p("The table shows job titles that match your selected filters, along with their AI Adoption Level and Automation Risk, categorized as High, Medium, or Low, as well as the Average Salary of those professions in US Dollars.")
    ),

    mainPanel(
      div(class = "output-table",
          tableOutput("job_list")
      ),
      textOutput("no_data_message") # Message when no data matches filters
    )
  )
)

# Define the server logic
server <- function(input, output, session) {

  # Create a reactive expression to filter the data based on user inputs
  filtered_data <- reactive({
    data <- AIriskjobs

    if (input$Industry != "All") {
      data <- data |> filter(Industry == input$Industry)
    }
    if (input$Company_Size != "All") {
      data <- data |> filter(Company_Size == input$Company_Size)
    }

    # Select relevant columns
    data |> select(Job_Title, AI_Adoption_Level, Automation_Risk, Salary_USD)
  })

  # Render the table with all data when no filter is applied
  output$job_list <- renderTable({
    if (nrow(filtered_data()) == 0) {
      output$no_data_message <- renderText("No data matches the selected filters.")
      NULL
    } else {
      output$no_data_message <- renderText("")  # Clear message if data is present
      filtered_data()
    }
  })

  # Observe the clear filters button
  observeEvent(input$clear_filters, {
    updateSelectInput(session, "Industry", selected = "All")
    updateSelectInput(session, "Company_Size", selected = "All")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
