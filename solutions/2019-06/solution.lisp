(ql:quickload :alexandria)

;; TODO: lisp helper script with this in it
(defmacro do-file-lines ((line-var file-name) &body body)
  "Executes body for each line in file, with line-var set to that line as a
  string"
  (alexandria:with-gensyms (stream-var)
    `(alexandria:with-input-from-file (,stream-var ,file-name)
       (do ((,line-var (read-line ,stream-var nil) (read-line ,stream-var nil)))
           ((null ,line-var))
         ,@body))))

(let ((direct-orbit-alist))
  (do-file-lines (ln "~/Downloads/day6.input")
    (push (cons
           (intern (subseq ln 0 3))
           (intern (subseq ln 4)))
          direct-orbit-alist))
  (labels ((indirect-orbits (orbitee &optional parent-orbits)
             (cons
              (cons orbitee parent-orbits)
              (loop for (c-orbitee . c-orbiter) in direct-orbit-alist
                 when (equal c-orbitee orbitee)
                 append (indirect-orbits c-orbiter (cons orbitee parent-orbits)))))
           (first-common-element (one two)
             "Return first common element of both lists"
             (if (member (car one) two)
                 (car one)
                 (first-common-element (cdr one) two))))
    (let* ((all-orbits-alist (indirect-orbits 'com))
           (part-1 (apply #'+ (mapcar #'length (mapcar #'cdr all-orbits-alist))))
           (san-parents (cdr (assoc 'san all-orbits-alist)))
           (you-parents (cdr (assoc 'you all-orbits-alist)))
           (common-ancestor (first-common-element san-parents you-parents))
           (part-2 (+ 
                    (position common-ancestor you-parents)
                    (position common-ancestor san-parents))))
      (values part-1 part-2))))
