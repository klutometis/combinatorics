@(heading "Abstract")

@(text "{{Combinatorics}} provides some mechanisms for iterating over,
reducing and mapping permutations (ordered subsets) and
combinations (unordered subsets) of lists.")

@(text "{{Combinatorics}} supports partial, i.e.
''k''-permutations and partial, i.e. ''k''-combinations.")

@(heading "Documentation")

(define ordered-subset-for-each
  @("Iterate over every ''k''-permutation (partial ordered subset) of {{list}},
calling {{f}} for its side effect."
    (f "The function to call")
    (list "The list to permute")
    (k "''k'' distinct elements (default: ''n'')"))
  (case-lambda
   ((f list)
    (ordered-subset-for-each f list (length list)))
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
  @("Recombine every ''k''-permutation (partial ordered subset) of {{list}},
starting with a base-case {{nil}}, and calling {{cons}} with 1. a
permutation and 2. the accumulated value."
    (cons "The combining function")
    (nil "The base case")
    (list "The list to recombine")
    (k "''k'' distinct elements (default: ''n'')")
    (@to "object"))
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
  @("Map every ''k''-permutation (partial ordered subset) of {{list}} using {{f}}."
    (f "The mapping function")
    (list "The list to map")
    (k "''k'' distinct elements (default: ''n'')")
    (@to "list"))
  (case-lambda
   ((f list) (ordered-subset-map f list (length list)))
   ((f list k)
    (ordered-subset-fold (lambda (v a) (cons (f v) a)) '() list k))))

(define (project subset list)
  (vector-fold (lambda (i projection j)
                 (cons (list-ref list j) projection))
               '()
               subset))

;;; Thanks, Daniel Ángel Jiménez:
;;; <http://www.cs.utexas.edu/users/djimenez/utsa/cs3343/lecture25.html>.
(define unordered-subset-for-each
  @("Iterate over every ''k''-combination (partial unordered subset) of {{list}},
calling {{f}} for its side effect."
    (f "The function to call")
    (list "The list to permute")
    (k "''k'' distinct elements (default: ''n'')"))
  (case-lambda
   ((f list)
    (unordered-subset-for-each f list (length list)))
   ((f list k)
    (let ((subset (make-vector k))
          (n (length list)))
      (let iter ((start 0)
                 (p 0))
        (if (= p k)
            (f (project subset list))
            (do ((i start (+ i 1)))
                ((= i n))
              (vector-set! subset p i)
              (iter (add1 i) (add1 p)))))))))

(define unordered-subset-fold
  @("Recombine every ''k''-combination (partial unordered subset) of {{list}},
starting with a base-case {{nil}}, and calling {{cons}} with 1. a
combination and 2. the accumulated value."
    (cons "The combining function")
    (nil "The base case")
    (list "The list to recombine")
    (k "''k'' distinct elements (default: ''n'')")
    (@to "object"))
  (case-lambda
   ((cons nil list)
    (unordered-subset-fold cons nil list (length list)))
   ((cons nil list k)
    (let ((nil (make-parameter nil)))
      (unordered-subset-for-each
       (lambda (subset)
         (nil (cons subset (nil))))
       list
       k)
      (nil)))))

(define unordered-subset-map
  @("Map every ''k''-combination (partial unordered subset) of {{list}} using {{f}}."
    (f "The mapping function")
    (list "The list to map")
    (k "''k'' distinct elements (default: ''n'')")
    (@to "list"))
  (case-lambda
   ((f list) (unordered-subset-map f list (length list)))
   ((f list k)
    (unordered-subset-fold (lambda (v a) (cons (f v) a)) '() list k))))

(define permutation-for-each
  @("Synonym for [[#ordered-subset-for-each]]")
  ordered-subset-for-each)

(define permutation-fold
  @("Synonym for [[#ordered-subset-fold]]")
  ordered-subset-fold)

(define permutation-map
  @("Synonym for [[#ordered-subset-map]]")
  ordered-subset-map)

(define combination-for-each
  @("Synonym for [[#unordered-subset-for-each]]")
  unordered-subset-for-each)

(define combination-fold
  @("Synonym for [[#unordered-subset-fold]]")
  unordered-subset-fold)

(define combination-map
  @("Synonym for [[#unordered-subset-map]]")
  unordered-subset-map)
