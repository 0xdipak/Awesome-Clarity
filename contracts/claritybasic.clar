;; Clarity Basics I



;; Day 3 - Booleans and Read-Only (Part I & Part II)
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

;; Day 4 - Uints, Ints and Simple Operators
(define-read-only (add) 
(+ u1 u1)
)

(define-read-only (substract) 
(- 1 2)
)

(define-read-only (multiply) 
(* u2 u3)
)
(define-read-only (divide) 
(/ u6 u2)
)


(define-read-only (uint-to-int) 
(to-int u4)
)

(define-read-only (int-to-uint) 
(to-uint 4)
)



;; Day 5 - Advanced Operators

;; power
(define-read-only (exponent) 
(pow u5 u2)
)

;; square root
(define-read-only (sq-root) 
(sqrti (* u5 u7))
)

;; modulo operator
(define-read-only (fn-modulo) 
(mod u20 u3)
)

;; log2 
(define-read-only (log-two) 
(log2 u25)
)


;;Day 6 - Strings & Concatenating

(define-read-only (hello-world) 
(concat "Hello" " World!")

)

(define-read-only (hello-world-name) 
    (concat 
        (concat "Hello" " World!,")
        " Clarity"
    )
)

