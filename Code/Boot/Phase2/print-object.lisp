(cl:in-package #:sicl-boot-phase2)

(defgeneric print-object (object stream))

(cl:defmethod cl:print-object ((object sicl-boot-phase1::heap-instance) stream)
  (print-object object stream))

(defmethod print-object (object stream)
  (print-unreadable-object (object stream)
    (format stream "*some target-object")))

(defmethod print-object ((object function) stream)
  (print-unreadable-object (object stream)
    (format stream "*a function")))

(defmethod print-object ((object standard-object) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard-object")))

(defmethod print-object ((object funcallable-standard-object) stream)
  (print-unreadable-object (object stream)
    (format stream "*a funcallable-standard-object")))

(defmethod print-object ((object metaobject) stream)
  (print-unreadable-object (object stream)
    (format stream "*a metaobject")))

(defmethod print-object ((object generic-function) stream)
  (print-unreadable-object (object stream)
    (format stream "*a generic function")))

(defmethod print-object ((object standard-generic-function) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard generic function")))

(defmethod print-object ((object method) stream)
  (print-unreadable-object (object stream)
    (format stream "*a method")))

(defmethod print-object ((object standard-method) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard method")))

(defmethod print-object ((object standard-accessor-method) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard accessor method")))

(defmethod print-object ((object standard-reader-method) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard reader method")))

(defmethod print-object ((object standard-writer-method) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard writer method")))

(defmethod print-object ((object slot-definition) stream)
  (print-unreadable-object (object stream)
    (format stream "*a slot definition")))

(defmethod print-object ((object direct-slot-definition) stream)
  (print-unreadable-object (object stream)
    (format stream "*a direct slot definition")))

(defmethod print-object ((object effective-slot-definition) stream)
  (print-unreadable-object (object stream)
    (format stream "*an effective slot definition")))

(defmethod print-object ((object standard-slot-definition) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard slot definition")))

(defmethod print-object ((object standard-direct-slot-definition) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard direct slot definition")))

(defmethod print-object ((object standard-effective-slot-definition) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard effective slot definition")))

(defmethod print-object ((object method-combination) stream)
  (print-unreadable-object (object stream)
    (format stream "*a method combination")))

(defmethod print-object ((object specializer) stream)
  (print-unreadable-object (object stream)
    (format stream "*a specializer")))

(defmethod print-object ((object eql-specializer) stream)
  (print-unreadable-object (object stream)
    (format stream "*an eql specializer")))

(defmethod print-object ((object forward-referenced-class) stream)
  (print-unreadable-object (object stream)
    (format stream "*a forward referenced class")))

(defmethod print-object ((object real-class) stream)
  (print-unreadable-object (object stream)
    (format stream "*a real class")))

(defmethod print-object ((object built-in-class) stream)
  (print-unreadable-object (object stream)
    (format stream "*a built-in class")))

(defmethod print-object ((object regular-class) stream)
  (print-unreadable-object (object stream)
    (format stream "*a regular class")))

(defmethod print-object ((object standard-class) stream)
  (print-unreadable-object (object stream)
    (format stream "*a standard class")))

(defmethod print-object ((object funcallable-standard-class) stream)
  (print-unreadable-object (object stream)
    (format stream "*a funcallable standard class")))
