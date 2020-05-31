

# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable

pageWithSidebar(
  headerPanel('Amazon Vacuums k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(data)),
    selectInput('ycol', 'Y Variable', names(data), selected = names(data)[[2]]),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

