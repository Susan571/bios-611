# Makefile

all: plot1.png plot2.png

plot1.png plot2.png: Hw5.R
    Rscript $<

clean:
    rm -f plot1.png plot2.png
