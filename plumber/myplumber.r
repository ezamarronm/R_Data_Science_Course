install.packages("plumber")

#* @param message
#* @get /echo
function(msg = ""){
  list(msn = paste0("The text is ",msg))
}

