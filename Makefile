all: run parens

fact-c:fact.c
	@printf 'Compiling fact.c\n'
	@$(CC) -o fact-c fact.c

HANDLER='(coerce (lambda ()   \
				   (handler-case   \
					   (ccl:quit (let ((result (main (first ccl:*command-line-argument-list*)   \
													 (rest ccl:*command-line-argument-list*))))   \
								   (finish-output *standard-output*)   \
								   (finish-output *error-output*)   \
								   (cond   \
									 ((typep result (quote (signed-byte 32))) result)   \
									 ((null result) 0)   \
									 (t             1))))   \
					 (error (err)   \
					   (format *error-output* "~%~A~%" err)   \
					   (finish-output *error-output*)   \
					   (ccl:quit 1))))   \
				(quote function))'
LISP=ccl
fact-lisp:fact.lisp
	@printf 'Compiling fact.lisp\n'
	@$(LISP) --no-init \
		--eval '(load (compile-file "fact.lisp"))' \
		--eval '(ccl::save-application "fact-lisp" :toplevel-function (function main) :init-file nil :error-handler :quit :purify t :mode #o755 :prepend-kernel t)'

run:fact-c fact-lisp
	@printf '==== fact.c =======\n'
	@time ./fact-c
	@printf '\n'
	@printf '==== fact.lisp ====\n'
	@time ./fact-lisp
	@printf '\n'
	@printf '===================\n'

define count_parens
	printf '%-20s%4d parentheses, braces, brackets, angle-brackets, semi-colons, commas\n' \
		"$(1)" \
		$$(cat $(2) | sed -e 's/[^][<>(){};,]//g'|tr -d '\012'|wc -c)
endef


parens:
	@printf '\n'
	@$(call count_parens,fact.lisp,fact.lisp)
	@$(call count_parens,fact.c,fact.c)
	@for f in fact.{lisp,c} ; do printf '\n==== %s ====\n\n'  "$$f" ; cat "$$f" ; done
	@printf '\n'
	@printf '===================\n'

clean:
	-@rm -f fact-c fact-lisp fact.[dl]x{86,64}* *.o
