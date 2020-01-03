dat <- read.csv ('vote-2019-002.csv')
fa <- factanal (~ F + B + A + D + H + E + G + fd, 4, dat, scores = "regression",
                rotation = "promax")
ld <- fa$loadings
pdf (file = "vote-2019-002-factanal.pdf", width = 5, height = 5)
par (mar = c (5, 4, 0, 0) + 0.2)
plot (ld, type = "n", las = 1)
text (ld, row.names (ld), cex = 1.5)
dummy <- dev.off ()
