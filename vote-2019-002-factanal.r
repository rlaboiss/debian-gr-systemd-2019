dat <- read.csv ('vote-2019-002.csv')

fa <- factanal (~ F + B + A + D + H + E + G + fd, 4, dat, scores = "regression",
                rotation = "promax")
ld <- fa$loadings

png (file = "f1-f2-loadings.png", , width = 400, height = 400)
plot (ld, type = "n", las = 1, xlab ="factor #1", ylab ="factor #2")
text (ld, row.names (ld), cex = 1.5)
dummy <- dev.off ()

png (file = "factors.png", width = 600, height = 400)
layout (matrix (seq (1, 4), nrow = 2, byrow = TRUE))
for (i in seq (1, 4)) {
    par (mar = c (5, 4, 0, 0) + 0.2)
    barplot (ld [, i], ylab = sprintf ("factor #%d", i), las = 1)
}
dummy <- dev.off ()

