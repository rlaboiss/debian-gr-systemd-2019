dat <- read.csv ('vote-2019-002.csv')

fa <- factanal (~ F + B + A + D + H + E + G + fd, 4, dat, scores = "regression",
                rotation = "promax")

cat ("===== Exploratory factorial analysis\n")
show (fa)

ld <- fa$loadings

png (file = "f1-f2-loadings.png", , width = 400, height = 400)
plot (ld, type = "n", las = 1, xlab ="factor #1", ylab ="factor #2")
text (ld, row.names (ld), cex = 1.5)
dummy <- dev.off ()

png (file = "factors-loadings.png", width = 600, height = 400)
layout (matrix (seq (1, 4), nrow = 2, byrow = TRUE))
for (i in seq (1, 4)) {
    par (mar = c (5, 4, 0, 0) + 0.3)
    barplot (ld [, i], ylab = "", las = 1, cex.axis = 1.5, cex.names = 1.5)
    text (9, max (ld [, i]), sprintf ("#%d", i), adj = c (1, 1), cex = 2)
}
dummy <- dev.off ()

png (file = "f1-f2-scores.png", width = 400, height = 400)
sc <- fa$scores
par (mar = c (5, 4, 0, 0) + 0.2)
plot (sc [, 1], sc [, 2], pch = 19, col = "#00000080", las = 1,
      xlab = "factor #1", ylab ="factor #2", cex.axis = 1.5)
dummy <- dev.off ()

png (file = "factors-scores.png", width = 600, height = 400)
set.seed (0)
layout (matrix (seq (1, 4), nrow = 2, byrow = TRUE))
for (i in seq (1, 4)) {
    par (mar = c (5, 4, 0, 0) + 0.3)
    ds <- density (sc [, i])
    max.x <- max (ds$x)
    max.y <- max (ds$y)
    plot (ds$x, ds$y, ylim = c (-0.2, 1) * max.y, type = "l", las = 1,
          cex.axis = 1.5, ylab = "", xlab = "")
    abline (h = 0, col = "gray")
    points (sc[,3], runif (nrow (sc), -0.15 * max.y, -0.05 * max.y), pch = 19,
            col = "#00000080", cex = 0.4)
    text (max.x, max.y, sprintf ("#%d", i), adj = c (1, 1), cex = 2)
}
dummy <- dev.off ()

cat ("\n===== Correlation between factors #1 and #2\n")
show (cor.test (sc [, 1], sc [, 2]))
