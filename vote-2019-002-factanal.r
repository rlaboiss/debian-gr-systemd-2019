dat <- read.csv ('vote-2019-002.csv')
fa <- factanal (~ F + B + A + D + H + E + G + fd, 2, dat, scores = "regression")
km <- kmeans (fa$loadings, 4)
pdf (file = "vote-2019-002-factanal.pdf", width = 5, height = 5)
par (mar = c (5, 4, 0, 0) + 0.2)
plot (fa$loadings, type = "n", las = 1)
for (i in seq (1, 4)) {
    idx <- which (km$cluster == i)
    lines (fa$loadings [idx, 1], fa$loadings [idx, 2], lwd = 30,
           col = "#ff000080", ljoin = 0)
}
text (fa$loadings,  names (dat) [2:9], cex = 1.5)
dummy <- dev.off ()
