#################################################################################################################################################
#
# LGBTSurvey2017 USER INTERFACE (See server.R file)
#
#
# VERSION:
#   1.0
#
# AUTHOR:
#   T. Dougall
#
# WRITTEN:
#   October 2018
#
#
# *UPDATES*
#
# VERSION:
#
# UPDATED BY:
#
# DATE:
#
# DETAILS:
#
#################################################################################################################################################

options(stringsAsFactors = FALSE)



shinyUI(fluidPage(theme="shiny.css",
  navbarPage("lgbt-survey-2017 beta",theme = "shiny.css", inverse = FALSE,
             tabPanel("Home",
                      wellPanel(
HTML(
"<h3>Home Page</h3>
<br>
<p> Welcome to the <b> National LGBT Survey 2017 Data Viewer. </b> 
</p>
<p> The Data Viewer allows you to find information about the experiences of LGBT people in the UK who responded to the National LGBT survey in 2017.
You can view results on the themes of safety, education, health, and employment for different LGBT groups.
</p>
<br>
<p> <b> To know before your start </b>
</p>
<p> The survey received 108,100 responses from people who self-identified as having a minority sexual orientation or gender identity, or self-identified as intersex; were 16 or above; and lived in the United Kingdom.
As such, the dataset represents a self-selected sample and is not representative of all LGBT people in the UK - the results hold for respondents to the survey only.
</p>
<p> The research report of the survey results, including full details on methodology can be found <a href='https://www.gov.uk/government/publications/national-lgbt-survey-summary-report'>here</a>.
</p>
<p> Data in cells with a low number of respondents (5 or under) has been suppressed to prevent disclosure (marked 'x' in tables).
For questions where respondents could select a single response; if a single cell in a column has been suppressed then the second smallest has also been suppressed.
Where there were no respondents in a particular cell this is marked '-' in the tables.
</p>
<p> Charts and base numbers have also been rounded to the nearest 10 respondents to prevent disclosure. For some questions, respondents were able to tick as many answer categories as applied. As a result, some totals may not add up to 100%.
</p>
<br>
<p> <b> How to use the Data Viewer </b> 
</p>
<p> The Data Viewer gives you access to over half a million tables from the survey dataset.
</p>
<p> To generate tables, please go to the 'Analyse' tab. You can select a theme, a sub-theme and the question you are interested on the left-hand side of the app.
You can use the 'Question Index' tab to identify questions and themes of interest.
</p>
<p> You will then need to choose whether you would like to look at responses from all survey respondents, cisgender respondents or trans respondents.
Responses provided by cisgender respondents or trans respondents can then be disaggregated further - you use filters to explore different sub-sections of these groups.
</p>
<p> The graphs within the app are auto-generated. If you want to view a chart for just some rows of any table you can select those rows and click 'Reset / update graph'.
</p>
")),
img(src='logo_geo.jpg',width="274", height="143",align="left")),
             tabPanel("Terminology",
                      wellPanel(HTML(
"
<h3> Terminology </h3>
<br>
<p> For the purposes of the Data Viewer, the following terms are used: </p>"
),
uiOutput("terminology"))),
             tabPanel("Analyse",
  titlePanel("National LGBT Survey 2017"),
  
  fluidRow(
    column(12,
           conditionalPanel(  
             condition = "input.chooseFilter3Option == null",
             wellPanel(h5(strong("Please wait while data is loaded into the app, initial loading can take a minute"))
             ))
    ),
    column(3,
           wellPanel(
             h5(strong("Choose a dataset"),br(),"In this panel you will choose which part of the survey you would like to view.",br(),br(),"First, pick a theme of the survey,
                most themes are then split into sub-themes followed by multiple questions."),
             br(),
             h5(strong("Theme")),
             uiOutput("chooseChapter"),
             h5(strong("Sub-theme")),
             uiOutput("chooseSection"),
             h5(strong("Question")),
             uiOutput("chooseQuestion")),
           wellPanel(
             h5(strong("All / Trans / Cisgender respondents")),
             uiOutput("chooseFilter1Option"),
             h5(strong("Category")),
             uiOutput("chooseDemographic")),
           wellPanel(
             conditionalPanel(
               condition = "input.chooseFilter1Option == 'All'",
            h5(strong("Subset the data"),br(),"Further filtering is only available for Trans and Cisgender respondents.")),        
             conditionalPanel(
               condition = "input.chooseFilter1Option != 'All'",
             h5(strong("Subset the data"),br(),"You can now filter the respondents for who will appear in the table."),
             br(),
             h5(strong("Filter Respondents 1")),
             uiOutput("chooseFilter2"),
             uiOutput("chooseFilter2Option"),
             h5(strong("Filter Respondents 2")),
             uiOutput("chooseFilter3"),
             uiOutput("chooseFilter3Option")))),

      column(9,
             fluidRow(
               column(6,
                 conditionalPanel(  
                   condition = "input.chooseFilter3Option != null",
                   wellPanel(h5(strong("Load data"),br(),"Once you have chosen your data options, click to load the data - please wait for all options to generate before loading."),
                   actionButton("do", "Load data"))
                 )
               ),
               column(6,
                      conditionalPanel(  
                        condition = "input.chooseFilter3Option != null",
                        wellPanel(h5(strong("Download Table"),br(),"Here you can download the table you have created. It will download as a .csv file"),
                   downloadButton('downloadData', 'Download .csv of Results'))
                 )
               )
             ),
             fluidRow(
               
               column(12,
               conditionalPanel(  
                 condition = "input.do > 0",
                 uiOutput("NoData"),
                 uiOutput("Title")
                 ),
               br(),
             plotOutput("stackedplot"),
             br(),
             column(6,
                    conditionalPanel(  
                      condition = "input.do > 0",
             wellPanel(style = "overflow: hidden;",class = 'leftAlign',
             actionButton("GRAPH","Reset / update graph",
                                    style="color: #fff; background-color: #002664; border-color: #2e6da4"),
             br(), br(),
             "To update the graph, select the rows from the table below and click 'Reset / update graph'.",br(),
             "To clear previous row selections, once new data has been loaded please reset the graph."
             
             )
             )),
             br(),
             br(),
             conditionalPanel(  
               condition = "input.do > 0",
              DT::dataTableOutput("table")
               ),
             br(),
             conditionalPanel(
               condition = "input.do > 0",
              uiOutput("Notes")),
             br(),
             br())
             )

))), 
tabPanel("Question Index",
              wellPanel(uiOutput("glossary"))),
tabPanel("Help",
               wellPanel(HTML(
"<h3> Help Tab </h3>
<br>
<p> <b> Why can't I select other options if I select 'All respondents'? </b>
<br> Tables produced for all respondents cannot be disaggregated further. You need to select whether you would like to focus on cisgender respondents or trans respondents if you wish to disaggregate the data further.  
</p>
<p> <b> Why does '-' appear in my table? </b>
<br> This sign means that no respondents have selected this response.
</p>
<p> <b> Why does 'x' appear in my table? </b>
<br> This sign means that the number has been suppressed due to containing 5 or fewer respondents, in order to prevent disclosure. 
</p>
<p> <b> Why does my total not add up to 100%? </b>
<br> Some totals may not add up to 100% due to rounding or because for some questions, respondents were able to tick as many answer categories as applied. For these questions the total number of responses is higher than the total number of respondents.
</p>
<br>
<p> Can't find the help you are looking for? Please contact <a href='mailto:LGBT-APP.MAILBOX@geo.gov.uk?subject=LGBT Survey App Help'>LGBT-APP.MAILBOX@geo.gov.uk</a>.
</p>")))
)
))




