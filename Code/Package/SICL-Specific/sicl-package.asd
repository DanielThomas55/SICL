(cl:in-package #:asdf-user)

(defsystem :sicl-package
  :serial t
  :description "SICL-Specific Package System"
  :depends-on (:acclimation)
  :components ((:file "packages")
	       (:file "conditions")
	       (:file "condition-reporters-english")
	       (:file "documentation-strings-english")
	       (:file "functions-temp")))
