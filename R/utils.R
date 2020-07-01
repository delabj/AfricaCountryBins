.sb_invert <- function(hex_color, dark_color="black", light_color="white",
                       na_color="white") {

  hex_color <- gsub("#", "", hex_color)

  R <- suppressWarnings(as.integer(paste("0x", substr(hex_color,1,2), sep="")))
  G <- suppressWarnings(as.integer(paste("0x", substr(hex_color,3,4), sep="")))
  B <- suppressWarnings(as.integer(paste("0x", substr(hex_color,5,6), sep="")))

  YIQ <- ((R*299) + (G*587) + (B*114)) / 1000

  return(
    ifelse(is.na(YIQ), na_color,
           ifelse(
             YIQ >= 128, dark_color, light_color)
    )
  )
}

# sanity checks for country values
validate_countries <- function(country_data, country_col, merge.x, ignore_dupes=FALSE) {

  good_country<- country_data[,country_col] %in% country_coords[,merge.x]
  if (any(!good_country)) {
    invalid <- country_data[,country_col][which(!good_country)]
    country_data <- country_data[which(good_country),]
    warning("Found invalid country values: ", invalid)
  }

  if (!ignore_dupes) {
    dupes <- duplicated(country_data[,country_col])
    if (any(dupes)) {
      country_data <- country_data[which(!dupes),]
      warning("Removing duplicate country rows")
    }
  }

  return(country_data)

}

"%||%" <- function(a, b) { if (!is.null(a)) a else b }

.pt <- 2.84527559055118
