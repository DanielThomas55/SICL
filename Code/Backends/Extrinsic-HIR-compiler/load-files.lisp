(cl:in-package #:sicl-extrinsic-hir-compiler)

(defun rp (filename)
  (asdf:system-relative-pathname :sicl-extrinsic-hir-compiler filename))

(load (rp "../../Evaluation-and-compilation/lambda.lisp"))
(load (rp "../../Environment/multiple-value-bind.lisp"))
(load (rp "../../Data-and-control-flow/setf.lisp"))
(load (rp "../../Data-and-control-flow/multiple-value-list.lisp"))
(load (rp "../../Data-and-control-flow/nth-value.lisp"))
(load (rp "../../Environment/defun.lisp"))
(load (rp "../../Conditionals/macros.lisp"))
(load (rp "../../Environment/standard-environment-macros.lisp"))
(load (rp "../../Environment/standard-environment-functions.lisp"))
(load (rp "../../Data-and-control-flow/fboundp.lisp"))
(load (rp "../../Data-and-control-flow/fdefinition.lisp"))
(load (rp "../../Data-and-control-flow/setf-fdefinition.lisp"))
(load (rp "ensure-generic-function.lisp"))
