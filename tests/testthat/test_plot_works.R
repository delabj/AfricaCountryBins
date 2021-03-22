context("basic functionality")
test_that("faceting works", {

  require(ggplot2)
  require(AfricaCountryBins)

  data("africa_mines")


  a1 <- africa_mines
  a2 <- africa_mines
  a3 <- africa_mines

  a1$f <- 1
  a2$f <- 2
  a3$f <- 3

  a4 <- rbind.data.frame(rbind.data.frame(a1, a2), a3)


  ggplot(a4) +
    geom_countrybins_africa(
      aes(country =countrycode , fill=count )
      ) +
    coord_equal() +
    ggplot2::facet_wrap(~f) -> gg

  gb <- ggplot_build(gg)

  expect_equal(length(gb$plot$facet), 3)



})
