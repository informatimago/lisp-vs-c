all: fact-c fact-lisp
fact-c:
	cp lisp+c.lisp a.c && gcc -o a.out a.c && rm a.c
	./a.out && rm a.out
	@printf "\n"
fact-lisp:
	ccl -norc -l lisp+c.lisp
	@printf "\n"
.PHONY:: fact-c fact-lisp
parens:
	for f in lisp+c.{lisp,c} ; do printf '%-20s%4d parentheses\n' "$$f" $$(sed -e 's/[^][(){}]//g'<$$f|tr -d '\012'|wc -c) ; done
