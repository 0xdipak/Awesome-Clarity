;; Clarity Basics I
;; Day 3 - Booleans and Read-Only (Part I & Part II)
;; Day 4 - Uints, Ints and Simple Operators

;; Day - 3
(define-read-only (show-true-i) 
    true
)

(define-read-only (show-false-i) 
false
)

(define-read-only (show-true-ii) 
(not false)
)

(define-read-only (show-false-ii) 
(not true)
)


;; Day - 4
(define-read-only (add) 
(+ u1 u1)
)

(define-read-only (substract) 
(- 1 2)
)


