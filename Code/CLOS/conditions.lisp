(cl:in-package #:sicl-clos)

(define-condition class-name-must-be-non-nil-symbol
    (sicl-additional-conditions:sicl-type-error)
  ()
  (:default-initargs :type '(and symbol (not null))))

(define-condition attempt-to-add-existing-subclass
    (sicl-additional-conditions:sicl-error)
  ((%subclass :initarg :subclass :reader subclass)
   (%superclass :initarg :superclass :reader superclass)))

(define-condition readers-must-be-proper-list
    (sicl-additional-conditions:sicl-type-error)
  ((%slot-definition :initarg :slot-definition :reader slot-definition)
   (%readers :initarg :readers :reader readers))
  (:default-initargs :type 'list))

(define-condition malformed-documentation-option
    (sicl-additional-conditions:sicl-type-error)
  ()
  (:default-initargs :type 'list))

(define-condition attempt-to-access-precedence-list-of-unfinalized-class
    (sicl-additional-conditions:sicl-error)
  ((%offending-class :initarg :offending-class :reader offending-class)))

(define-condition no-such-class-name
    (sicl-additional-conditions:sicl-type-error)
  ()
  (:default-initargs :type 'symbol))

(define-condition slot-definition-argument-must-be-supplied
    (sicl-additional-conditions:sicl-error)
  ((%offending-class :initarg :offending-class :reader offending-class)))

(define-condition unable-to-compute-class-precedence-list
    (sicl-additional-conditions:sicl-error)
  ((%offending-class :initarg :offending-class :reader offending-class)))
