(module combinatorics
  (ordered-subset-fold
   ordered-subset-for-each
   ordered-subset-map
   unordered-subset-fold
   unordered-subset-for-each
   unordered-subset-map
   permutation-fold
   permutation-for-each
   permutation-map
   combination-fold
   combination-for-each
   combination-map)

  (import scheme)
  (cond-expand
    (chicken-4
      (import chicken)
      (use srfi-1 vector-lib))
    (chicken-5
      (import
        (chicken base)
        srfi-1
        vector-lib)))

  (include "combinatorics-core.scm"))
