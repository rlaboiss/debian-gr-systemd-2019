FIGURES = factors-loadings.png f1-f2-loadings.png f1-f2-scores.png

$(FIGURES) results.txt: vote-2019-002-factanal.r vote-2019-002.csv
	Rscript vote-2019-002-factanal.r  | sed 's/,  /,\n/' > results.txt

vote-2019-002.csv: process-tally.py vote_002_tally.txt
	python3 process-tally.py < vote_002_tally.txt

vote_002_tally.txt:
	wget https://www.debian.org/vote/2019/vote_002_tally.txt

.PHONY: dist
dist: veryclean
	cwd=$$(pwd) ; (cd .. ; tar cfvz $$cwd.tgz $$cwd)

.PHONY: clean
clean:
	rm -f vote-2019-002.csv

.PHONY: veryclean
veryclean: clean
	rm -f vote_002_tally.txt *.png
