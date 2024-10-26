# Load the required packages
library(shiny)
library(dplyr)

# Load your AIriskjobs dataset
# AIriskjobs <- read.csv("path/to/your/AIriskjobs.csv")

# Define the UI
ui <- fluidPage(
  titlePanel("AI and Automation Job Insights"),

  sidebarLayout(
    sidebarPanel(
      selectInput("Industry", "Select Industry:",
                  choices = unique(AIriskjobs$Industry)),
      selectInput("Company_Size", "Select Company Size:",
                  choices = unique(AIriskjobs$Company_Size)),
      selectInput("AI_Adoption_Level", "Select AI Adoption Level:",
                  choices = c("high", "medium", "low")),  # Fixed options
      selectInput("Automation_Risk", "Select Automation Risk:",
                  choices = c("high", "medium", "low")),  # Fixed options
      actionButton("filter_btn", "Filter")
    ),

    mainPanel(
      tableOutput("job_summary")
    )
  )
)

# Define the server logic
server <- function(input, output) {

  filtered_data <- eventReactive(input$filter_btn, {
    req(input$Industry, input$Company_Size, input$AI_Adoption_Level, input$Automation_Risk)

    AIriskjobs %>%
      filter(Industry == input$Industry,
             Company_Size == input$Company_Size,
             AI_Adoption_Level == input$AI_Adoption_Level,
             Automation_Risk == input$Automation_Risk) %>%
      group_by(Job_Title) %>%
      summarize(avg_salary = mean(Salary_USD, na.rm = TRUE)) %>%
      arrange(desc(avg_salary)) %>%
      slice_head(n = 3)
  })

  output$job_summary <- renderTable({
    filtered_data()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
