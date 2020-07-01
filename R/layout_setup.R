# This builds the dataframe of country coordinates for a grid
country_coords <- structure(
  list(
    abrv_2_letter = c(            "GM", "SN", "ML", "NG",
                            "GW", "SL", "GN", "BF", "SS", "TD", "ET",
                                  "LR", "GH", "TG", "BJ", "CM", "ER",
                      "CV",       "CI", "NG", "CM", "CD", "UG", "KE",
                                        "GQ", "GA", "BI", "RW", "TZ", "SC",
                                        "AO", "ZM", "MW", "MZ",
                                              "NA", "BW", "ZW",       "MG",
                                              "SZ", "LS",             "MU",
                                              "ZA"
                      ),
    abrv_3_letter = c(              "GMB", "SEN", "MLI", "NGA",
                             "GNB", "SLE", "GIN", "BFA", "SSD", "TCD", "ETH",
                                    "LBR", "GHA", "TGO", "BEN", "CMR", "ERI",
                      "CPV",        "CIV", "NGA", "CMR", "COD", "UGA", "KEN",
                                           "GNQ", "GAB", "BDI", "RWA", "TZA", "SYC",
                                           "AGO", "ZMB", "MWI", "MOZ",
                                                  "NAM", "BWA", "ZWE",        "MDG",
                                                  "SWZ", "LSO",               "MUS",
                                                  "ZAF"
                      ),


    country = c("Gambia", "Sengal", "Mali", "Niger",
                "Guinea-Bissau", "Seirra Leone", "Guinea", "Burkina Faso", "South Sudan", "Chad", "Ethiopia",
                "Liberia", "Ghana", "Togo", "Benin", "Central African Republic", "Eritrea",
                "Cape Verde", "Cote d'lvoire", "Nigeria", "Camaroon", "Democratic Republic of the Congo", "Uganda", "Kenya",
                "Equatorial Guinea", "Gabon", "Burundi", "Rwanda", "Tanzania", "Seychelles",
                "Angola", "Zambia", "Malawi", "Mozambique",
                "Namibia", "Botswana", "Zimbabwe", "Madagascar",
                "Swaziland", "Lesotho", "Mauritius",
                "South Africa"),
    col = c(      3L,4L,5L,6L,
               2L,3L,4L,5L,6L,7L,8L,
                  3L,4L,5L,6L,7L,8L,
            1L,   3L,4L,5L,6L,7L,8L,
                     4L,5L,6L,7L,8L,9L,
                        5L,6L,7L,8L,
                        5L,6L,7L,   9L,
                           6L,7L,   9L,
                           6L


            ),
    row = c(      1L,1L,1L,1L,
               2L,2L,2L,2L,2L,2L,2L,
                  3L,3L,3L,3L,3L,3L,
            4L,   4L,4L,4L,4L,4L,4L,
                     5L,5L,5L,5L,5L,5L,
                        6L,6L,6L,6L,
                        7L,7L,7L,   7L,
                           8L,8L,   8L,
                           9L


    )
  ),
  .Names = c(
    "abrv_2_letter",
             "abrv_3_letter",
             "country",
             "col",
             "row"
    ),
  class = "data.frame", row.names = c(NA, -42L)
)

# Order by Country Name
country_coords <- country_coords[order(country_coords$country),]


# Convert col/row to y and x
b_country_coords <- country_coords
colnames(b_country_coords) <- c(
                                "abrv_2_letter",
                                "abrv_3_letter",
                                "country",
                                "x",
                                "y"
                                )
# Convert Y to negative
b_country_coords$y <- -b_country_coords$y
