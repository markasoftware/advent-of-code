(defun fuel (tons &optional so-far)
  (if (< tons 9)
      so-far
    (let ((f (- (floor tons 3) 2)))
      (fuel f (+ (or so-far 0) f)))))

(with-current-buffer "aoc-input"
  (goto-char (point-min))
  (cl-loop for line = (buffer-substring-no-properties
                       (line-beginning-position) (line-end-position))
           while (< 0 (length line))
           for total = (+ (or total 0) (fuel (string-to-number line)))
           do (forward-line)
           finally (return total)))
