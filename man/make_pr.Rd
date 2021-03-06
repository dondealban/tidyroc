% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make-pr.r
\name{make_pr}
\alias{make_pr}
\title{Precision-recall curve}
\usage{
make_pr(data, ...)
}
\arguments{
\item{data}{data-frame that contains fitted values and known outcomes}

\item{predictor}{column in `data` that contains fitted values}

\item{known_class}{column in `data` that contains true or actual classification}
}
\description{
This function calculates precision and recall to plot a precision-recall curve
}
\examples{
library(tidyverse)
library(broom)
library(tidyroc)

# get `biopsy` dataset from `MASS`
data(biopsy, package = "MASS")

# change column names from `V1`, `V2`, etc. to informative variable names
colnames(biopsy) <-
  c(
    "ID",
    "clump_thickness",
    "uniform_cell_size",
    "uniform_cell_shape",
    "marg_adhesion",
    "epithelial_cell_size",
    "bare_nuclei",
    "bland_chromatin",
    "normal_nucleoli",
    "mitoses",
    "outcome"
  )

# fit a logistic regression model to predict tumour type
glm(outcome ~ clump_thickness + uniform_cell_shape,
  family = binomial,
  data = biopsy
) \%>\%
  augment() \%>\% # use broom to add glm output to the original data frame
  make_pr(predictor = .fitted, known_class = outcome) \%>\% # get values to plot an ROC curve
  ggplot(aes(x = recall, y = precision)) + # plot false positive rate against true positive rate
  geom_line()

}
