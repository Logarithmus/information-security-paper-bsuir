ifeq ($(OS),Windows_NT)
	SHELL=%WINDIR%/cmd.exe
	DROPBOX_PUBLIC=$(USERPROFILE)/Dropbox/Public
else
	SHELL=/usr/bin/env sh
	DROPBOX_PUBLIC=$(HOME)/Dropbox/Public
endif
PDFLATEX = pdflatex
DIPLOMA_REPORT_PDF = diploma_report
PRACTICE_REPORT_PDF = practice_report
PAPER_REPORT_PDF = paper
TITLE_PDF = diploma_title_only
TASK_PDF = diploma_task_only
BIBTEX = bibtex
RM = rm -f
GREP = grep


all: fast


publish_to_dropbox: all
	cp $(DIPLOMA_REPORT_PDF).pdf $(DROPBOX_PUBLIC)/$(DIPLOMA_REPORT_PDF).pdf
	cp $(PRACTICE_REPORT_PDF).pdf $(DROPBOX_PUBLIC)/$(PRACTICE_REPORT_PDF).pdf

fast: *.tex
	latexmk -pdf -pdflatex="pdflatex" $(PAPER_REPORT_PDF)
# mv $(PAPER_REPORT_PDF).pdf $(PAPER_REPORT_PDF)-`date +'%m-%d-%H-%M-%S'`.pdf

fastcheck: *.tex
	$(PDFLATEX) $(DIPLOMA_REPORT_PDF)
	$(BIBTEX) $(DIPLOMA_REPORT_PDF).aux
	$(PDFLATEX) $(DIPLOMA_REPORT_PDF)
	$(PDFLATEX) $(DIPLOMA_REPORT_PDF)
	mv $(DIPLOMA_REPORT_PDF).pdf $(DIPLOMA_REPORT_PDF)-`date +'%m-%d-%H-%M-%S'`.pdf


$(DIPLOMA_REPORT_PDF).pdf: *.tex
	$(PDFLATEX) $(DIPLOMA_REPORT_PDF)
	$(BIBTEX) $(DIPLOMA_REPORT_PDF).aux
	$(PDFLATEX) $(DIPLOMA_REPORT_PDF)
	$(PDFLATEX) $(DIPLOMA_REPORT_PDF)
	cp $(DIPLOMA_REPORT_PDF).pdf ../example_diploma.pdf


$(PRACTICE_REPORT_PDF).pdf: *.tex
	$(PDFLATEX) $(PRACTICE_REPORT_PDF)
	$(BIBTEX) $(PRACTICE_REPORT_PDF).aux
	$(PDFLATEX) $(PRACTICE_REPORT_PDF)
	$(PDFLATEX) $(PRACTICE_REPORT_PDF)
	cp $(PRACTICE_REPORT_PDF).pdf ../example_practice.pdf


$(PAPER_REPORT_PDF).pdf: *.tex
	$(PDFLATEX) $(PAPER_REPORT_PDF)
	$(BIBTEX) $(PAPER_REPORT_PDF).aux
	$(PDFLATEX) $(PAPER_REPORT_PDF)
	$(PDFLATEX) $(PAPER_REPORT_PDF)
	cp $(PAPER_REPORT_PDF).pdf ../example_paper_project.pdf

$(TITLE_PDF).pdf: *.tex
	$(PDFLATEX) $(TITLE_PDF)

$(TASK_PDF).pdf: *.tex
	$(PDFLATEX) $(TASK_PDF)


cleanall: clean
	$(RM)  *.pdf

.PHONY: clean
clean:
	$(RM) *.aux *.log *.out *.toc *.gz *.gz\(busy\) *.blg *.bbl $(DIPLOMA_REPORT_PDF).pdf $(TASK_PDF).pdf $(TITLE_PDF).pdf $(PRACTICE_REPORT_PDF).pdf $(PAPER_REPORT_PDF).pdf

