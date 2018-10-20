PACKAGE := brandeis-problemset
DIST_FILES := ${PACKAGE}.cls ${PACKAGE}.tex ${PACKAGE}-doc.sty ${PACKAGE}.pdf README.md example.tex example.pdf
TEXMF_ROOT := "${HOME}/texmf"
INSTALL_DIR := "$(TEXMF_ROOT)/tex/latex/${PACKAGE}"

${PACKAGE}.pdf: ${PACKAGE}.tex
	latexmk -norc -pdf ${PACKAGE}.tex

example.pdf: example.tex
	latexmk -norc -pdf example.tex

${PACKAGE}: $(DIST_FILES)
	mkdir ${PACKAGE}
	cp -t ${PACKAGE} $(DIST_FILES)
	chmod -x ${PACKAGE}/*
	chmod -x ${PACKAGE}

${PACKAGE}.tar.gz: ${PACKAGE}
	tar -czf ${PACKAGE}.tar.gz ${PACKAGE}

dist: ${PACKAGE}.tar.gz

tidy:
	# copied files
	rm -r ${PACKAGE}
	# all generated files but the pdf
	latexmk -norc -c

clean:
	make tidy
	rm ${PACKAGE}.tar.gz
	latexmk -norc -C

install: problemset
	install -d ${INSTALL_DIR}
	install $(DIST_FILES) ${INSTALL_DIR}
