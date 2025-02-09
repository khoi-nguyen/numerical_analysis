.PHONY: all clean

TEX_FILES = main.tex $(addprefix frontmatter/, syllabus.tex list_of_proofs.tex) $(wildcard mainmatter/*.tex)
PDF_OUTPUTS := $(addprefix build/, $(notdir $(TEX_FILES:.tex=.pdf)))
COMMON_DEPS := main.tex preamble.tex macros.tex

all : $(PDF_OUTPUTS)

main : build/main.pdf

build/main.pdf: main.tex $(TEX_FILES) $(COMMON_DEPS)
	latexmk -f $<

build/syllabus.pdf: frontmatter/syllabus.tex build/main.pdf $(COMMON_DEPS)
	cp build/main.aux build/syllabus.aux
	cp build/main.bbl build/syllabus.bbl
	lualatex \
		--output-directory='build' \
		-shell-escape \
		-jobname=syllabus \
		"\includeonly{frontmatter/syllabus}\input{main.tex}"

build/list_of_proofs.pdf: frontmatter/list_of_proofs.tex build/main.pdf $(COMMON_DEPS)
	cp build/main.aux build/list_of_proofs.aux
	cp build/main.bbl build/list_of_proofs.bbl
	lualatex \
		--output-directory='build' \
		-shell-escape \
		-jobname=list_of_proofs \
		"\includeonly{frontmatter/list_of_proofs}\input{main.tex}"

build/%.pdf: mainmatter/%.tex build/main.pdf $(COMMON_DEPS)
	cp build/main.aux build/$*.aux
	cp build/main.bbl build/$*.bbl
	lualatex \
		--output-directory='build' \
		-shell-escape \
		-jobname=$* \
		"\includeonly{mainmatter/$*}\input{main.tex}"

clean:
	rm -rf build
