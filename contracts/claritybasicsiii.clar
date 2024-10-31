
;; title: claritybasicsiii

;; Day 20 - Introduction To Lists I

(define-read-only (list-bool) 
    (list true false true)

;; >> (contract-call?  .claritybasicsiii  list-bool)
;; (list true false true)
)

(define-read-only (list-nums) 
    (list u1 u2 u3)
)

(define-read-only (list-strings) 
    (list "Hello" "World" "Dipak")
)

(define-read-only (list-principal) 
    (list tx-sender 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG)
)
