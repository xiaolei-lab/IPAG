library(shinyFiles)
library(rclipboard)

# Define UI ----
ui <- shinyUI(navbarPage(
    "IPAG",
    # HIBLUP ----
    tabPanel("GS/GP",
      rclipboardSetup(),
      tags$head(tags$script(src = "ipag.js")),
      tabsetPanel(
        tabPanel("Freqentist method",
                 h3("Powered by",tags$a(href = "https://github.com/XiaoleiLiuBio/rMVP","rMVP"),"","and",
                    tags$a(href = "https://hiblup.github.io/","HIBLUP")),
                 hr(),
                 h4("Step 1. Read data"),
                 # phenotype & effects
                 wellPanel(
                   HTML('<label>Please choose your <em>phenotype</em> file (including IDs, traits, and non-genomic effects) :  </label>'),
                   shinyFilesButton('hi_phe_file', 'Browse...', 'Please select a file', FALSE),
                   actionButton('hi_phe_example', 'Example', style = 'float: right;'),
                   textOutput('hi_phe_file_path'),
                   checkboxInput("hi_phe_header", "Header", TRUE),
                   radioButtons("hi_phe_sep", "Separator", inline = TRUE,
                                choiceNames = c("tab", "comma", "space"),
                                choiceValues = c("\t", "," ," ")),
                   DT::dataTableOutput('hi_phe_table')
                 ),

                 # pedigree
                 wellPanel(
                   HTML('<label>Please choose your <em>pedigree</em> file if needed:  </label>'),
                   shinyFilesButton('hi_ped_file', 'Browse...', 'Please select a file', FALSE),
                   actionButton('hi_ped_example', 'Example', style = 'float: right;'),
                   textOutput('hi_ped_file_path'),
                   checkboxInput("hi_ped_header", "Header", TRUE),
                   radioButtons("hi_ped_sep", "Separator", inline = TRUE,
                                choiceNames = c("tab", "comma", "space"),
                                choiceValues = c("\t", "," ," ")),
                   DT::dataTableOutput("hi_ped_table")
                 ),

                 # genotype
                 wellPanel(
                   HTML('<label>Please choose your <em>genotypes</em> file(*.vcf) if needed:</label>'),
                   shinyFilesButton('hi_geno_file', 'Browse...', 'Please select a file', FALSE),
                   actionButton('hi_geno_example', 'Example', style = 'float: right;'),
                   textOutput('hi_geno_file_path')
                 ),

                 h4("Step 2. Configure the model"),
                 # effects
                 wellPanel(
                   HTML('<label>Please choose your <em>column names</em> (separated by comma)</label>'),
                   actionButton('hi_effects_example', 'Example', style = 'float: right;'),
                   textInput("hi_id_traits", label = HTML("ID and Trait name")),
                   textInput("hi_fixed_effects_number", label = HTML("Fixed effects (covariates, i.e., continous variables)")),
                   textInput("hi_fixed_effects_factor", label = HTML("Fixed effects (factors, i.e., catogorical variables)")),
                   textInput("hi_random_effects", label = HTML("Random effects"))
                 ),

                 wellPanel(
                   HTML('<label>Please set other parameters</label>'),
                   actionButton('hi_config_example', 'Example', style = 'float: right;'),
                   numericInput("hi_cpu", "Number of Threads: (The default setting is 0 to use all cores)", 0),
                   radioButtons("hi_mode", "Mode:", inline = TRUE,
                                choiceNames = list("Additive model", "Additive & Dominant model"),
                                choiceValues = list("A", "AD")),
                   radioButtons("hi_vc.method", "Methods for variance components estimation:", inline = TRUE,
                                choices = list("HI", "AI", "EM", "AIEM", "HE"))
                 ),

                 h3("R Script"),
                 hr(),
                 verbatimTextOutput("hi_run_script"),
                 div(
                   downloadButton("hi_download_script", "Download", style = "margin-right: 5px;"),
                   uiOutput("hi_copy_script", inline = TRUE),
                   style = "margin-bottom: 10px;"
                 )
        ),
        # JWAS ----
        tabPanel("Bayesian method",
                 h3("Powered by ", tags$a(href = "https://github.com/reworkhow/JWAS.jl","JWAS")),
                 hr(),
                 h4("Step 1. Read data"),
                 # phenotype & effects
                 wellPanel(
                   HTML('<label>Please choose <em>phenotype</em> file (including IDs, traits, and non-genomic effects) :  </label>'),
                   shinyFilesButton('jw_phe_file', 'Browse...', 'Please select a file', FALSE),
                   actionButton('jw_phe_example', 'Example', style = 'float: right;'),
                   textOutput('jw_phe_file_path'),
                   checkboxInput("jw_phe_header", "Header", TRUE),
                   radioButtons("jw_phe_sep", "Separator", inline = TRUE,
                                choiceNames = c("tab", "comma", "space"),
                                choiceValues = c("\t", "," ," ")),
                   DT::dataTableOutput('jw_phe_table')
                 ),

                 # pedigree
                 wellPanel(
                   HTML('<label>Please choose <em>pedigree</em> file if needed:  </label>'),
                   shinyFilesButton('jw_ped_file', 'Browse...', 'Please select a file', FALSE),
                   actionButton('jw_ped_example', 'Example', style = 'float: right;'),
                   textOutput('jw_ped_file_path'),
                   checkboxInput("jw_ped_header", "Header", TRUE),
                   radioButtons("jw_ped_sep", "Separator", inline = TRUE,
                                choiceNames = c("tab", "comma", "space"),
                                choiceValues = c("\t", "," ," ")),
                   DT::dataTableOutput("jw_ped_table")
                 ),

                 # genotype
                 wellPanel(
                   HTML('<label>Please choose <em>genotypes</em> file(*.txt) if needed:</label>'),
                   shinyFilesButton('jw_geno_file', 'Browse...', 'Please select a file', FALSE),
                   actionButton('jw_geno_example', 'Example', style = 'float: right;'),
                   textOutput('jw_geno_file_path'),
                   checkboxInput("jw_geno_header", "Header", TRUE),
                   radioButtons("jw_geno_sep", "Separator", inline = TRUE,
                                choiceNames = c("tab", "comma", "space"),
                                choiceValues = c("\t", "," ," ")),
                   DT::dataTableOutput("jw_geno_table")
                 ),
                 h4("Step 2. Build model"),
                 # effects
                 wellPanel(
                   HTML('<label>Please enter <em>column names</em>(Separated by commas)</label>'),
                   actionButton('jw_effects_example', 'Example', style = 'float: right;'),
                   textInput("jw_id_traits", label = HTML("ID and Trait name")),
                   textInput("jw_fixed_effects_number", label = HTML("Fixed effects (covariates, i.e., continous variables)")),
                   textInput("jw_fixed_effects_factor", label = HTML("Fixed effects (factors, i.e., catogorical variables)")),
                   textInput("jw_random_effects", label = HTML("Random effects"))
                 ),
                 h4("Step 3. Set model parameters"),
                 wellPanel(
                   HTML('<label>Part1. MCMC parameters:</label>'),
                   actionButton('jw_config_example', 'Example', style = 'float: right;'),
                   numericInput("jw_chain_length", label = "Chain length",value = 5000),
                   numericInput("jw_output_samples_frequency",label = "Output samples frequency",value = 100),
                   numericInput("jw_burnin",label = "burnin",value = 0),


                   HTML('<label>Part2. Method parameters:</label>'),
                   radioButtons("jw_methods", "Method",
                                choices = c("conventional (no markers)", "RR-BLUP", "BayesA", "BayesB", "BayesC", "Bayesian Lasso")),
                   numericInput("jw_pi", label = "Pi",value = 0.0),
                   fluidRow(
                     column(4,
                            checkboxInput("jw_estimate_variance", "estimate variance", TRUE),
                            checkboxInput("jw_estimatepi", "estimatePi", FALSE),
                            checkboxInput("jw_pedigree", "pedigree", FALSE)),
                     column(4,
                            checkboxInput("jw_single_step_analysis", "single step analysis", FALSE),
                            checkboxInput("jw_categorical_trait", "categorical trait", FALSE),
                            checkboxInput("jw_constraint", "constraint", FALSE)),
                     column(4,
                            checkboxInput("jw_causal_structure", "causal structure", FALSE),
                            checkboxInput("jw_missing_phenotypes", "missing phenotypes", TRUE))),


                   HTML('<label>Part3. Genomic Prediction parameters:</label>'),
                   fluidRow(
                     column(4,checkboxInput("jw_outputebv", "outputEBV", TRUE)),
                     column(4,checkboxInput("jw_output_heritability", "output heritability", TRUE))),

                   HTML('<label>Part4. Other parameters:</label>'),
                   checkboxInput("jw_printout_model_info", "printout model info", TRUE)
                 ),
                 h3("Juila Script"),
                 hr(),
                 verbatimTextOutput("jw_run_script"),
                 div(
                   downloadButton("jw_download_script", "Download", style = "margin-right: 5px;"),
                   uiOutput("jw_copy_script", inline = TRUE),
                   style = "margin-bottom: 10px;"
                 )
        )
      )
    ),
    tabPanel("GWAS",
      h2("Under construction")
    ),
    tabPanel("...",
      h2("Under construction")
    )
))

bool_juila <- function(x) {
  if (x) {
    return("true")
  } else {
    return("false")
  }
}

# Define server logic ----
server <- shinyServer(function(input, output, session) {
    volumes <- c(Home = fs::path_home(), getVolumes()(), Example = system.file("example", package = "IPAG"))

    # HIBLUP Phenotype file ----
    observe({
      shinyFileChoose(input, 'hi_phe_file', session = session, roots = volumes)
      if (!is.null(input$hi_phe_file)) {
        hi_phe_file <- parseFilePaths(volumes, input$hi_phe_file)
        output$hi_phe_file_path <- renderText(
          paste("File path:", hi_phe_file$datapath)
        )
        if (length(hi_phe_file$datapath) > 0 && file.exists(hi_phe_file$datapath)) {
          output$hi_phe_table <- DT::renderDataTable(
            DT::datatable(read.table(hi_phe_file$datapath, header = input$hi_phe_header, sep = input$hi_phe_sep, stringsAsFactors = FALSE))
          )
        }
      }
    })

    # example
    observeEvent(input$hi_phe_example, {
      updateRadioButtons(session, "hi_phe_sep", selected = ",")
      updateCheckboxInput(session, "hi_phe_header", value = TRUE)
      session$sendCustomMessage("UpdateShinyFiles", list(id = "hi_phe_file", message = list(files = "phenotypes.txt", root = "Example")))
    })

    # HIBLUP Pedigree file ----
    observe({
      shinyFileChoose(input, 'hi_ped_file', session = session, roots = volumes)
      if (!is.null(input$hi_ped_file)) {
        file_selected <- parseFilePaths(volumes, input$hi_ped_file)
        output$hi_ped_file_path <- renderText(
          paste("File path:", file_selected$datapath)
        )
        if (length(file_selected$datapath) > 0 && file.exists(file_selected$datapath)) {
          output$hi_ped_table <- DT::renderDataTable(
            DT::datatable(read.table(file_selected$datapath, header = input$hi_ped_header, sep = input$hi_ped_sep, stringsAsFactors = FALSE))
          )
        }
      }
    })

    # example
    observeEvent(input$hi_ped_example, {
      updateRadioButtons(session, "hi_ped_sep", selected = ",")
      updateCheckboxInput(session, "hi_ped_header", value = TRUE)
      session$sendCustomMessage("UpdateShinyFiles", list(id = "hi_ped_file", message = list(files = "pedigree.txt", root = "Example")))
    })

    # HIBLUP Genotype file ----
    observe({
      shinyFileChoose(input, 'hi_geno_file', session = session, roots = volumes, filetypes = c('', 'vcf'))
      if (!is.null(input$hi_geno_file)) {
        file_selected <- parseFilePaths(volumes, input$hi_geno_file)
        output$hi_geno_file_path <- renderText(
          paste("File path:", file_selected$datapath)
        )
      }
    })

    # example
    observeEvent(input$hi_geno_example, {
      session$sendCustomMessage("UpdateShinyFiles", list(id = "hi_geno_file", message = list(files = "genotypes.vcf", root = "Example")))
    })

    # HIBLUP Effects ----
    observeEvent(input$hi_effects_example, {
      updateTextInput(session, "hi_id_traits", value = "ID,y1")
      updateTextInput(session, "hi_fixed_effects_number", value = "x1")
      updateTextInput(session, "hi_fixed_effects_factor", value = "x2,x3")
      updateTextInput(session, "hi_random_effects", value = "dam")
    })

    # HIBLUP config ----
    observeEvent(input$hi_config_example, {
      updateNumericInput(session, "hi_cpu", value = 0)
      updateRadioButtons(session, "hi_mode", selected = "A")
      updateRadioButtons(session, "hi_mode", selected = "HI")
    })

    # HIBLUP Script ----
    observe({
      # browser()
      hi_phe_file <- parseFilePaths(volumes, input$hi_phe_file)
      hi_ped_file <- parseFilePaths(volumes, input$hi_ped_file)
      hi_geno_file <- parseFilePaths(volumes, input$hi_geno_file)

      script <- c("library(rMVP)", "library(hiblup)", "")

      # HIBLUP Read Phenotype ----
      if (length(hi_phe_file$datapath) > 0) {
        script <- c(script,
                    paste0("pheno <- read.table('", hi_phe_file$datapath, "', header=", input$hi_phe_header,", sep='", input$hi_phe_sep,"')"))
      }

      # HIBLUP Read Pedigree ----
      if (length(hi_ped_file$datapath) > 0) {
        script <- c(script,
                    paste0("pedigree <- read.table('", hi_ped_file$datapath, "', header=", input$hi_ped_header,", sep='", input$hi_ped_sep,"')"),
                    "")
      }

      # HIBLUP Read Genotype ----
      if (length(hi_geno_file$datapath) > 0) {
        script <- c(script,
                    paste0("MVP.Data(fileVCF='", hi_geno_file$datapath, "', out='hiblup')"),
                    "geno <- attach.big.matrix('hiblup.geno.desc')",
                    "geno.id <- read.table('hiblup.geno.ind')",
                    "map <- read.table('hiblup.geno.map')",
                    "")
      }

      # HIBLUP Fixed effects ----
      if (!is.null(input$hi_fixed_effects_factor) && !is.null(input$hi_fixed_effects_number)) {
        if (input$hi_fixed_effects_factor != "" || input$hi_fixed_effects_number != "") {
          hi_fixed_effects_factor <- unlist(strsplit(input$hi_fixed_effects_factor, ","))
          hi_fixed_effects_number <- unlist(strsplit(input$hi_fixed_effects_number, ","))

          x <- unlist(sapply(hi_fixed_effects_factor, function(i){paste0("as.factor(", i, ")")}))
          x <- c(x, hi_fixed_effects_number)

          script <- c(script,
                      paste0("X <- model.matrix(~", paste0(x, collapse = "+"), ", data = pheno)"),
                      "")
        }
      }

      # HIBLUP Random effects ----
      if (!is.null(input$hi_random_effects)) {
        if (input$hi_random_effects != "") {
          hi_random_effects <- unlist(strsplit(input$hi_random_effects, ","))
          r <- paste(shQuote(hi_random_effects, type = "cmd"), collapse = ", ")
          script <- c(script,
                      paste0("R <- as.matrix(pheno[, c(", r, ")])"),
                      "")
        }
      }
      # Call HIBLUP ----
      if (length(hi_phe_file$datapath) > 0) {
        # data type
        g <- ""
        if (length(hi_ped_file$datapath) > 0) {
          g <- paste0(g, "pedigree = pedigree, ")
        }
        if (length(hi_geno_file$datapath) > 0) {
          g <- paste0(g, "geno = geno, map = map, geno.id = geno.id, ")
        }
        cpu <- ""
        if (input$hi_cpu != 0) {
          cpu <- paste("cpu =", input$hi_cpu, ", ")
        }
        hi_id_traits <- unlist(strsplit(input$hi_id_traits, ","))
        hi_id_traits <- paste(shQuote(hi_id_traits, type = "cmd"), collapse = ", ")
        script <- c(script, paste0(
          "gebv <- hiblup(pheno = pheno[, c(", hi_id_traits,")], ", g, cpu, "vc.method = c('", input$hi_vc.method,"'), mode = '", input$hi_mode,"', CV = X, R = R)"
        ))
      }

      output$hi_run_script <- renderText(paste(script, collapse = "\n"))

      # HIBLUP download & copy ----
      output$hi_download_script <- downloadHandler(
        filename = "run_hiblup.R",
        content = function(file) {
          writeLines(script, file)
        }
      )
      output$hi_copy_script <- renderUI({
        rclipButton("hi_copy_script_btn", "Copy",
                    clipText = paste(script, collapse = "\n"),
                    icon = icon("clipboard"))
      })
    })

    # JWAS Phenotype file ----
    observe({
      shinyFileChoose(input, 'jw_phe_file', session = session, roots = volumes)
      if (!is.null(input$jw_phe_file)) {
        file_selected <- parseFilePaths(volumes, input$jw_phe_file)
        output$jw_phe_file_path <- renderText(
          paste("File path:", file_selected$datapath)
        )
        if (length(file_selected$datapath) > 0 && file.exists(file_selected$datapath)) {
          output$jw_phe_table <- DT::renderDataTable(
            DT::datatable(read.table(file_selected$datapath, header = input$jw_phe_header, sep = input$jw_phe_sep, stringsAsFactors = FALSE))
          )
        }
      }
    })

    # example
    observeEvent(input$jw_phe_example, {
      updateRadioButtons(session, "jw_phe_sep", selected = ",")
      updateCheckboxInput(session, "jw_phe_header", value = TRUE)
      session$sendCustomMessage("UpdateShinyFiles", list(id = "jw_phe_file", message = list(files = "phenotypes.txt", root = "Example")))
    })

    # JWAS Pedigree file ----
    observe({
      shinyFileChoose(input, 'jw_ped_file', session = session, roots = volumes)
      if (!is.null(input$jw_ped_file)) {
        file_selected <- parseFilePaths(volumes, input$jw_ped_file)
        output$jw_ped_file_path <- renderText(
          paste("File path:", file_selected$datapath)
        )
        if (length(file_selected$datapath) > 0 && file.exists(file_selected$datapath)) {
          output$jw_ped_table <- DT::renderDataTable(
            DT::datatable(read.table(file_selected$datapath, header = input$jw_ped_header, sep = input$jw_ped_sep, stringsAsFactors = FALSE))
          )
        }
      }
    })

    # example
    observeEvent(input$jw_ped_example, {
      updateRadioButtons(session, "jw_ped_sep", selected = ",")
      updateCheckboxInput(session, "jw_ped_header", value = TRUE)
      session$sendCustomMessage("UpdateShinyFiles", list(id = "jw_ped_file", message = list(files = "pedigree.txt", root = "Example")))
    })

    # JWAS Genotype file ----
    observe({
      shinyFileChoose(input, 'jw_geno_file', session = session, roots = volumes, filetypes = c('', 'txt'))
      if (!is.null(input$jw_geno_file)) {
        file_selected <- parseFilePaths(volumes, input$jw_geno_file)
        output$jw_geno_file_path <- renderText(
          paste("File path:", file_selected$datapath)
        )
        if (length(file_selected$datapath) > 0 && file.exists(file_selected$datapath)) {
          output$jw_geno_table <- DT::renderDataTable(
            DT::datatable(read.table(file_selected$datapath, header = input$jw_geno_header, sep = input$jw_geno_sep, stringsAsFactors = FALSE))
          )
        }
      }
    })

    # example
    observeEvent(input$jw_geno_example, {
      updateRadioButtons(session, "jw_geno_sep", selected = ",")
      updateCheckboxInput(session, "jw_geno_header", value = TRUE)
      session$sendCustomMessage("UpdateShinyFiles", list(id = "jw_geno_file", message = list(files = "genotypes.txt", root = "Example")))
    })

    # JWAS effects example ----
    observeEvent(input$jw_effects_example, {
      updateTextInput(session, "jw_id_traits", value = "ID,y1")
      updateTextInput(session, "jw_fixed_effects_number", value = "x1")
      updateTextInput(session, "jw_fixed_effects_factor", value = "x2,x3")
      updateTextInput(session, "jw_random_effects", value = "dam")
    })
    # JWAS config example ----
    observeEvent(input$jw_config_example, {
      updateRadioButtons(session, "jw_methods", selected = "BayesC")
      updateNumericInput(session, "jw_chain_length", value = 5000)
      updateNumericInput(session, "jw_output_samples_frequency", value = 100)
      updateNumericInput(session, "jw_burnin", value = 0)
      updateNumericInput(session, "jw_pi", value = 0.0)
      updateCheckboxInput(session, "jw_outputebv", value = TRUE)
      updateCheckboxInput(session, "jw_estimatepi", value = FALSE)
      updateCheckboxInput(session, "jw_estimate_variance", value = TRUE)
      updateCheckboxInput(session, "jw_single_step_analysis", value = FALSE)
      updateCheckboxInput(session, "jw_categorical_trait", value = FALSE)
      updateCheckboxInput(session, "jw_missing_phenotypes", value = TRUE)
      updateCheckboxInput(session, "jw_causal_structure", value = FALSE)
      updateCheckboxInput(session, "jw_constraint", value = FALSE)
      updateCheckboxInput(session, "jw_pedigree", value = FALSE)
      updateCheckboxInput(session, "jw_output_heritability", value = TRUE)
      updateCheckboxInput(session, "jw_printout_model_info", value = TRUE)
    })

    # JWAS Script ----
    observe({
      jw_phe_file <- parseFilePaths(volumes, input$jw_phe_file)
      jw_ped_file <- parseFilePaths(volumes, input$jw_ped_file)
      jw_geno_file <- parseFilePaths(volumes, input$jw_geno_file)

      script <- c("using JWAS,DataFrames,CSV", "")

      # JWAS Read Phenotype ----
      if (length(jw_phe_file$datapath) > 0) {
        script <- c(script,
                    paste0('phenotypes = CSV.read("', jw_phe_file$datapath,
                           '", header=', bool_juila(input$jw_phe_header),
                           ', delim="', input$jw_phe_sep,'", missingstrings=["NA"])'))
      }

      # JWAS Read Pedigree ----
      if (length(jw_ped_file$datapath) > 0) {
        script <- c(script,
                    paste0('pedigree = get_pedigree("', jw_ped_file$datapath,
                           '", header=', bool_juila(input$jw_ped_header),
                           ', separator="', input$jw_ped_sep,'")'),
                    "")
      }

      # JWAS effects ----
      jw_fixed_effects_factor <- unlist(strsplit(input$jw_fixed_effects_factor, ","))
      jw_fixed_effects_number <- unlist(strsplit(input$jw_fixed_effects_number, ","))
      jw_random_effects <- unlist(strsplit(input$jw_random_effects, ","))

      jw_id <- unlist(strsplit(input$jw_id_traits, ","))[1]
      jw_traits <- unlist(strsplit(input$jw_id_traits, ","))[-1]

      # JWAS Build Model ----
      script <- c(script,
                  paste0('model_equation = "', jw_traits, ' = intercept + ', paste0(c(jw_fixed_effects_factor, jw_fixed_effects_number, jw_random_effects, jw_id), collapse = " + "),'"'),
                  "model = build_model(model_equation);",
                  "")

      # JWAS Covariates ----
      script <- c(script,
                  paste0('set_covariate(model,"', paste(jw_fixed_effects_number, collapse = " "),'");')
      )

      # JWAS Random ----
      for (r in jw_random_effects) {
        script <- c(script,
                    paste0('set_random(model,"', r, '");')
        )
      }

      # JWAS pedigree
      if (length(jw_ped_file$datapath) > 0) {
        script <- c(script,
                    paste0('set_random(model,"', jw_id, '", pedigree);'),
                    "")
      }

      # JWAS genotype
      if (length(jw_geno_file$datapath) > 0 && input$jw_methods != "conventional (no markers)") {
        script <- c(script,
                    paste0('genofile = "', jw_geno_file$datapath, '";'),
                    paste0("add_genotypes(model, genofile,",
                           "separator='", input$jw_geno_sep,
                           "', header=", bool_juila(input$jw_ped_header), ");"),
                    "")
      }

      # Call JWAS ----
      script <- c(script,
                  paste0('out=runMCMC(model, phenotypes, ',
                         'methods="', input$jw_methods, '", ',
                         'Pi=', input$jw_pi,', ',
                         'estimatePi=', bool_juila(input$jw_estimatepi), ', ',
                         'outputEBV=', bool_juila(input$jw_outputebv), ', ',
                         'chain_length=', input$jw_chain_length, ', ',
                         'buinin=',input$jw_burnin,', ',
                         'output_samples_frequency=', input$jw_output_samples_frequency, ', ',
                         'estimate_variance=', bool_juila(input$jw_estimate_variance), ', ',
                         'single_step_analysis=', bool_juila(input$jw_single_step_analysis), ', ',
                         'categorical_trait=', bool_juila(input$jw_categorical_trait), ', ',
                         'missing_phenotypes=', bool_juila(input$jw_missing_phenotypes), ', ',
                         'causal_structure=', bool_juila(input$jw_causal_structure), ', ',
                         'constraint=', bool_juila(input$jw_constraint), ', ',
                         'pedigree=', bool_juila(input$jw_pedigree), ', ',
                         'output_heritability=', bool_juila(input$jw_output_heritability), ', ',
                         'printout_model_info=', bool_juila(input$jw_printout_model_info),
                         ');')
      )
      output$jw_run_script <- renderText(paste(script, collapse = "\n"))

      # JWAS download & copy ----
      output$jw_download_script <- downloadHandler(
        filename = "run_JWAS.R",
        content = function(file) {
          writeLines(script, file)
        }
      )
      output$jw_copy_script <- renderUI({
        rclipButton("jw_copy_script_btn", "Copy",
                    clipText = paste(script, collapse = "\n"),
                    icon = icon("clipboard"))
      })
    })
})


# Run the app ----
shinyApp(ui = ui, server = server)



