
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

(define-data-var num-list (list 10 uint) (list u1 u2 u3 u4))
(define-data-var principal-list (list 5 principal) (list tx-sender 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 ))


;; Element-At (index -> value)
(define-read-only (element-at-num-list (index uint)) 
    (element-at? (var-get num-list) index)

;; >> (contract-call?  .claritybasicsiii  element-at-num-list u2)
;; (some u3)
)

(define-read-only (element-at-principal-list (index uint)) 
    (element-at? (var-get principal-list) index)

;; >> (contract-call?  .claritybasicsiii  element-at-principal-list u0)
;; (some 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
)


;; Index-Of (value -> index)

;; NOTE : If we have repeated list like (u1 u2 u3 u1) and if we call index of u1 it will always gives result of first element.
(define-read-only (index-of-nums (item uint)) 
    (index-of? (var-get num-list) item)

;; >> (contract-call?  .claritybasicsiii  index-of-nums u4)
;; (some u3)
)

(define-read-only (index-of-principal (item principal)) 
    (index-of? (var-get principal-list) item)

;; >> (contract-call?  .claritybasicsiii  index-of-principal 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG)
;; (some u1)
)


;; Day 21 - Intro. To Lists II & Intro. To Unwrapping I


