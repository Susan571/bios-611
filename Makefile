.PHONY: clean


clean:
	rm -rf figures
	rm -rf .created-dirs
	rm -f clean_data.csv
	rm -f data_explore.txt
	rm -f data_analysis.txt
	rm -f report.pdf

.created-dirs:
	mkdir -p figures
	touch .created-dirs

#clean the dataset
clean_data.csv: .created-dirs data_clean.R \
	data/cardio_train.csv
	Rscript data_clean.R

#basic facts and analysis text output for the dataset
data_explore.txt: data_clean.R \
	data/cardio_train.csv
	Rscript data_clean.R

data_analysis.txt: .created-dirs clean_data.csv model_fit.R
		Rscript model_fit.R


#generated figures for final report to use
figures/stroke_variables.png: .created-dirs data_visualization.R clean_data.csv
	Rscript data_visualization.R

figures/variable_distributions.png: .created-dirs data_visualization.R clean_data.csv
	Rscript data_visualization.R

#figures from data analysis and model fitting
figures/pca.png: .created-dirs data_visualization.R clean_data.csv
	Rscript data_visualization.R


figures/roc.png: .created-dirs model_fit.R clean_data.csv
	Rscript model_fit.R

# Build the final report for the project
report.pdf: figures/cardio_variables.png \
	figures/variable_distributions.png \
	figures/pca.png \
	figures/roc.png
		R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"