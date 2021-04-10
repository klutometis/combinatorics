(import
  combinatorics
  test)

(test "Permutations"
      '((b c) (a c) (c b) (a b) (c a) (b a))
      (ordered-subset-map values '(a b c) 2))

(test "Combinations"
      '((c b) (c a) (b a))
      (unordered-subset-map values '(a b c) 2))
