#******************************************************************************#
#                                                                              #
#                          Lab 2 - CPE Standard                                #
#                                                                              #
#              Arnau Sangra Rocamora - Data Driven Securty                     #
#                                                                              #
#******************************************************************************#

# Install Dependencies, if needed
if (!suppressMessages(suppressWarnings(require("xml2", quietly = T)))) {
  suppressMessages(suppressWarnings(install.packages("xml2", repos = "http://cran.rstudio.com/", quiet = T, dependencies = T)))
}
library(xml2)


cpe.file <- "./official-cpe-dictionary_v2.3.xml"
# Download XML File
if(!file.exists(cpe.file)){
  compressed_cpes_url <- "https://nvd.nist.gov/feeds/xml/cpe/dictionary/official-cpe-dictionary_v2.3.xml.zip"
  cpes_filename <- "cpes.zip"
  download.file(compressed_cpes_url, cpes_filename)
  unzip(zipfile = cpes_filename)
}



GetCPEItems <- function(cpe.raw) {
  #cpe <- NewCPEItem()
  ns <- xml_ns(cpe.raw)
  cpe.raw <- xml2::xml_find_all(cpe.raw, "/d1:cpe-list/*", ns)
  # Remove first item (generator tag)
  cpe.raw <- cpe.raw[-1]


  # transform the list to data frame
  cpe_title <- xml_text(xml2::xml_find_all(cpe.raw, ".//*[contains(local-name(), 'title')]" ))
  #cpe_references <- xml2::xml_find_all(cpe.raw, ".//references")
  cpe23_name <- xml_attr(xml2::xml_find_all(cpe.raw, ".//cpe-23:cpe23-item"), "name")

  df <- cbind.data.frame(cpe23_name, cpe_title, stringsAsFactors=FALSE)

  # return data frame
  return(df)
}

# Initializate Data Frame
#NewCPEItem <- function(){
#  cpe <- data.frame(name = att.name,
#                    status = att.status,
#                    abstraction = att.abstraction,
#                    completeness = att.completeness,
#                    description = att.descr,
#                    stringsAsFactors = F)
#
#  return(cpe)}


CleanCPEs <- function(cpes){

  # data manipulation

  return(data.frame(cpes))
}


ParseCPEData <- function(cpe.file) {

  # load cpes as xml file
  cpes <- xml2::read_xml(x = cpe.file)

  #xml_children(cpes)
  #ns <- xml_ns(cpes)

  # get CPEs
  cpes <- GetCPEItems(cpes)

  # transform, clean, arrange parsed cpes as data frame
  df <- CleanCPEs(cpes)

  # return data frame
  return(df)
}
