(define ordered-subset-for-each
  (case-lambda
   ((f list)
    (ordered-subset-for-each list (length list)))
   ((f list k)
    (let iter ((list list)
               (k k) 
               (subset '()))
      (if (zero? k)
          (f subset)
          (for-each
              (lambda (element)
                (iter (delete element list)
                      (sub1 k)
                      (cons element subset)))
            list))))))

(define ordered-subset-fold
  (case-lambda
   ((cons nil list)
    (ordered-subset-fold cons nil list (length list)))
   ((cons nil list k)
    (let ((nil (make-parameter nil)))
      (ordered-subset-for-each
       (lambda (subset)
         (nil (cons subset (nil))))
       list k)
      (nil)))))

(define ordered-subset-map
  (case-lambda
   ((f list) (ordered-subset-map f list (length list)))
   ((f list k)
    (ordered-subset-fold cons '() list k))))
