#Makefile for LaTeX/BibTeX
#DISCLAIMER
#This Makefile is only tested with GNU Make

all:pdf

target=main
output=main

TEXFILES= $(wildcard ./*.tex)
EPS= $(wildcard ./figs/*.eps)
PNG= $(wildcard ./figs/*.png)
PSTEX= $(wildcard ./figs/*.pstex)
REFERENCES=$(wildcard ../*.bib)
STYFILES=$(wildcard ./*.sty)
page=1 #The page variable is used to open target pdf file on a certain page with xpdf
LATEX=latex
PDFLATEX=pdflatex
PDFLATEXFLAGS=-job-name
LATEXFLAGS=--src-specials # Enables jump from dvi file to tex file
PS2PDF=ps2pdf14 # has to be pdf 1.3 for pstex files to be nice in the pdf
PS2DFPFLAGS=-dCompatibilityLevel=1.4 -dMAxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true -sPAPERSIZE=b5
DVIPS=dvips
DVIPSFLAGS=-D600 -Pamz -Pcmz -j0 -z #-Ppdf -G0 -ta4
# -z preserves the hyperref links
MAKEINDEX=makeindex
NOMENCLSTYLE=nomencl.ist
BIBTEX=bibtex
ECHOFLAGS=-e "\033[5;35;40m" #echo is Magenta and flashing
RESETCOLOR=-en "\033[0m" #echo is reset
PDFREADER=AcroRd32
pdf: $(output).pdf


# init: 
# #Generates the corresponding .sty files
# 	$(LATEX) $(LATEXFLAGS) totpages.ins
# 	$(LATEX) $(LATEXFLAGS) datetime.ins
# 	$(LATEX) $(LATEXFLAGS) fixme.ins
# 	$(LATEX) $(LATEXFLAGS) showlabels.ins

#$(target).dvi:	$(target).bbl
#		@echo $(ECHOFLAGS) "Building $(target).dvi"
#		@echo $(RESETCOLOR)
#		$(LATEX) $(LATEXFLAGS) $(target).tex 
#		$(LATEX) $(LATEXFLAGS) $(target).tex
#		$(LATEX) $(LATEXFLAGS) $(target).tex 
#		@echo $(ECHOFLAGS) "$(target).dvi built."
#		@echo $(RESETCOLOR)

#$(target).bbl:	$(REFERENCES) $(TEXFILES) $(target).tex $(EPS) $(PSTEX) $(STYFILES)
#		@echo $(ECHOFLAGS) "Building $(target).bbl"
#		@echo $(RESETCOLOR)
#		$(LATEX) $(LATEXFLAGS) $(target).tex
#		$(BIBTEX) $(target)
#		$(MAKEINDEX) $(target).nlo -s $(NOMENCLSTYLE) -o $(target).nls
#		@echo $(ECHOFLAGS) "Built $(target).bbl"
#		@echo $(RESETCOLOR)

$(output).pdf:	$(REFERENCES) $(TEXFILES) $(PNG) $(target).tex $(EPS) $(PSTEX) $(STYFILES)
		@echo $(ECHOFLAGS) "Buildingz z$(target).pdf"
		@echo $(RESETCOLOR)
		$(PDFLATEX)  $(PDFLATEXFLAGS)=$(output) $(target).tex
#		$(BIBTEX) $(target)
#		$(MAKEINDEX) $(target).nlo -s $(NOMENCLSTYLE) -o $(target).nls
#		$(PDFLATEX)  $(PDFLATEXFLAGS)=$(ouput) $(target).tex
#		$(PDFLATEX)  $(PDFLATEXFLAGS)=$(ouput) $(target).tex
		$(PDFLATEX) $(PDFLATEXFLAGS)=$(output) $(target).tex
		$(PDFLATEX) $(PDFLATEXFLAGS)=$(output) $(target).tex
		@echo $(ECHOFLAGS) "Built $(target).bbl $(target)$(DATE)"
		@echo $(ECHOFLAGS) "$(DATE)"
		@echo $(RESETCOLOR)

.PHONY: clear

clear:	
	@rm -f *.toc
	@rm -f *.idx
	@rm -f *.log
	@rm -f *.tex.bak
	@rm -f  *.aux
# 	@rm -f  $(target).bbl # Maybe not a good idea!
	@rm -f  $(output).out  
	@rm -f  $(output).dlg
	@rm -f  $(output).ilg	
	@rm -f  $(output).nlo
	@rm -f  $(output).nls
	@rm -f $(output).blg
	@rm -f $(output).brf
	@rm -f $(output).lof
	@rm -f $(output).lot
	@rm -f $(output).bmt
	@rm -f $(output).lox
	@rm -f $(output).mtc
	@rm -f $(output).mtc1
	@rm -f $(output).mtc2
	@rm -f $(output).rel
#	@rm -f $(target).dvi
	@echo $(ECHOFLAGS) "Files removed"
	@echo $(RESETCOLOR)
clean:
	@echo $(ECHOFLAGS) "Removing $(output).dvi, .ps and .pdf files"
	@echo $(RESETCOLOR)
	@rm -f $(output).dvi
	@rm -f $(output).ps
	@rm -f $(output).pdf


show: $(output).pdf
	@echo  $(ECHOFLAGS) "Opening $(output).pdf on page $(page)"
	@echo $(RESETCOLOR)	
	@-$(PDFREADER) /A "page=$(page)=OpenActions" $(output).pdf &

# showkdvi: $(target).dvi
# 	-kdvi $(target).dvi -g $(page) &

# showxpdf: $(target).pdf
# #The page variable is used to open target pdf file on a certain page with xpdf
# 	-xpdf $(target).pdf $(page) &

# showacroread: $(target).pdf
# 	-acroread $(target).pdf &

# showevince: $(target).pdf
# 	-evince $(target).pdf &

# html:	
# 	@echo $(ECHOFLAGS) Uploading target pdf ps to homepage
# 	scp $(target).pdf control:/stud/06gr936/public_html/
# 	scp $(target).ps control:/stud/06gr936/public_html/
