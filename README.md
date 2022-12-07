---
editor_options:
  markdown:
    wrap: 72
    canonical: true
---

# AdvancedR3 project

This project is about learning more neat features about R that can be
used in our main scientific projects

# Brief description of folder and file contents

The following folders contain:

-   `data/`: lipodomics.rda - data we will use for our statistical
    analysis
-   `doc/`: two markdown files, a lesson.Rmd and report.Rmd. Lesson is a
    playground where we can test functions before implementing. report
    contains our final output.
-   `R/`: contains our functions

# Installing project R package dependencies

Install dependencies by opening the `coexpressionanalysis.Rproj` file
and run this command in the console:

    # install.packages("remotes")
    remotes::install_deps()

You'll need to have remotes installed for this to work.

# Resource

For more information on this folder and file workflow and setup, check
out <https://r-cubed-advanced.rostools.org/>
