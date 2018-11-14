(defun fact (x)
  (if (zerop x)
      1
      (* x (fact (1- x)))))

(defun main ()
  (format t "~%~D! = ~D~%" 42 (fact 42))
  (quit 0))
