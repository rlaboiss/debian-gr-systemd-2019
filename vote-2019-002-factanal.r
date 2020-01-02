dat <- read.csv ('vote-2019-002.csv')
fa <- factanal (~ F + B + A + D + H + E + G + fd, 2, dat, scores = "regression")
ld <- fa$loadings
km <- kmeans (ld, 4)
pdf (file = "vote-2019-002-factanal.pdf", width = 5, height = 5)
par (mar = c (5, 4, 0, 0) + 0.2)
plot (ld, type = "n", las = 1)
for (i in seq (1, 4)) {
    idx <- which (km$cluster == i)
    lines (ld [idx, 1], ld [idx, 2], lwd = 30, col = "#ff000080",
           ljoin = 0)
}
text (ld, row.names (ld), cex = 1.5)
dummy <- dev.off ()
