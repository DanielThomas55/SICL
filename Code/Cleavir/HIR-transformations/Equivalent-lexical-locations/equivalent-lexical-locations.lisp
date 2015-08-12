(cl:in-package #:cleavir-equivalent-lexical-locations)

;;; Return true if and only if two sets contain the same objects.  Use
;;; TEST to determine whether two objects are the same.
(defun set-equality (set1 set2 test)
  (and (null (set-difference set1 set2 :test test))
       (null (set-difference set2 set1 :test test))))

;;; Return true if and only if two equivalence classes are the same.
;;; Recall that an equivalence class is a set (represented as a list)
;;; of lexical locations.
(defun class-equality (class1 class2)
  (set-equality class1 class2 #'eq))

;;; Return true if and only if two partitions are the same.  Recall
;;; that a partition is a set (represented as a list) of equivalence
;;; classes.
(defun partition-equality (partition1 partition2)
  (set-equality partition1 partition2 #'class-equality))

;;; Given a partition and a lexical location, return a new partition
;;; that is like the original one, except that the lexical location
;;; has been removed.  Recall that the lexical location is a member of
;;; at most one of the equivalence classes of PARTITION.  Since we do
;;; not include equivalence classes with a single lexical location in
;;; them, we need to remove any such equivalence class before
;;; returning the result.
(defun remove-location (partition location)
  (let ((class (find location partition :test #'member)))
    (cond ((null class)
	   ;; LOCATION is not represented in PARTITION, meaning it is
	   ;; in an equivalence class by itself.  We return the
	   ;; original partition unmodified.
	   partition)
	  ((= (length class) 2)
	   ;; LOCATION is present, and it is in an equivalence class
	   ;; with exactly one more location.  Since we are removing
	   ;; LOCATION from the partition, the other location is from
	   ;; now one by itself in its equivalence class, and since we
	   ;; do not include such equivalence classes in the
	   ;; representation, we remove the entire equivalence class
	   ;; from the result.
	   (remove class partition :test #'eq))
	  (t
	   ;; LOCATION is present, and it is in an equivalence class
	   ;; with at least two more locations.  We need to return a
	   ;; partition that is like the original one, except that we
	   ;; need to replace the class that LOCATION is in by one
	   ;; that no longer contains LOCATION.
	   (cons (remove location class :test #'eq)
		 (remove class partition :test #'eq))))))

(defun add-equivalence (partition defined used)
  (let ((class (find used partition :test #'member)))
    (if (null class)
	(cons (list defined used) partition)
	(cons (cons defined class)
	      (remove class partition :test #'eq)))))

(defun update-for-meet (instruction partition)
  (let ((temp partition))
    (loop for output in (cleavir-ir:outputs instruction)
	  do (setf temp (remove-location temp output)))
    (if (typep instruction 'cleavir-ir:assignment-instruction)
	(let ((input (first (cleavir-ir:inputs instruction)))
	      (output (first (cleavir-ir:outputs instruction))))
	  (if (and (typep input 'cleavir-ir:lexical-location)
		   (typep output 'cleavir-ir:lexical-location))
	      (add-equivalence temp output input)
	      temp))
	temp)))

(defun update-for-join (partition1 partition2)
  (let* ((locations1 (reduce #'append partition1 :from-end t))
	 (locations2 (reduce #'append partition2 :from-end t))
	 (common (intersection locations1 locations2 :test #'eq))
	 (p1 (loop for class in partition1
		   for stripped = (intersection class common :test #'eq)
		   when (> (length stripped) 1)
		     collect stripped))
	 (p2 (loop for class in partition2
		   for stripped = (intersection class common :test #'eq)
		   when (> (length stripped) 1)
		     collect stripped))
	 (result '()))
    (loop until (null common)
	  do (let* ((location (first common))
		    (class1 (find location p1 :test #'member))
		    (class2 (find location p2 :test #'member))
		    (intersection (intersection class1 class2 :test #'eq))
		    (diff1 (set-difference class1 intersection :test #'eq))
		    (diff2 (set-difference class2 intersection :test #'eq)))
	       (setf common (set-difference common intersection :test #'eq))
	       (setf p1 (remove class1 p1 :test #'eq))
	       (setf p2 (remove class2 p2 :test #'eq))
	       (when (> (length intersection) 1)
		 (push intersection result))
	       (when (> (length diff1) 1)
		 (push diff1 p1))
	       (when (> (length diff2) 1)
		 (push diff2 p2))))
    result))

(defun compute-equivalent-lexical-locations (initial-instruction)
  (let ((work-list (list initial-instruction))
	(before (make-hash-table :test #'eq))
	(after (make-hash-table :test #'eq)))
    (setf (gethash initial-instruction before) '())
    (loop until (null work-list)
	  do (let ((instruction (pop work-list)))
	       (when (typep instruction 'cleavir-ir:enclose-instruction)
		 (let ((enter (cleavir-ir:code instruction)))
		   (setf (gethash enter before) '())
		   (push enter work-list)))
	       (setf (gethash instruction after)
		     (update-for-meet instruction (gethash instruction before)))
	       (loop for successor in (cleavir-ir:successors instruction)
		     for predecessors = (cleavir-ir:predecessors successor)
		     for join = (if (= (length predecessors) 1)
				    (gethash (first predecessors) after)
				    (reduce #'update-for-join
					    (mapcar (lambda (p)
						      (gethash p after))
						    predecessors)))
		     when (or (null (nth-value 1 (gethash successor before)))
			      (not (partition-equality
				    join (gethash successor before))))
		       do (setf (gethash successor before) join)
			  (push successor work-list))))
    before))