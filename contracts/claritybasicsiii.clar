
;; title: claritybasicsiii

;;;;;;;;;;;;;;;;;;;;;;;;;; Day 20 - Introduction To Lists I ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Day 21 - Intro. To Lists II & Intro. To Unwrapping I ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define-data-var list-day-21 (list 5 uint) (list u1 u2 u3 u4))

(define-read-only (list-len) 
    (len (var-get list-day-21))

;; >> (contract-call?  .claritybasicsiii  list-len)
;; u4
)

(define-public (add-to-list (new-num uint)) 
(ok 
    (var-set list-day-21 

       (unwrap! 
            (as-max-len? (append (var-get list-day-21) new-num) u5)
            (err u0)
        )
    )
)

;; >> (contract-call?  .claritybasicsiii add-to-list u5)
;; (ok (list u1 u2 u3 u4 u5))

;; >> (contract-call?  .claritybasicsiii add-to-list u6)
;; (err u0)
)




;;;;;;;;;;;;;;;;;;;;;;;;;; Day 22 - Introduction To Unwrapping II ;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Unwrap! -> Optionals & response(define-public (add-to-list (new-num uint)) 
(define-public (unwrap-example (new-num uint)) 
(ok 
    (var-set list-day-21 

       (unwrap! 
            (as-max-len? (append (var-get list-day-21) new-num) u5)
            (err "err list at max-len")
        )
    )
)

;; >> (contract-call?  .claritybasicsiii unwrap-example u5)
;; (ok true)
;; >> (contract-call?  .claritybasicsiii unwrap-example u6)
;; (err "err list at max-len")

)

;; Unwrap-err! -> Response
(define-public (unwrap-error-example (input (response uint uint))) 
    (ok (unwrap-err! input (err u10)))
)

;; Unwrap-panic -> Optional & response
(define-public (unwrap-panic-example (new-num uint)) 
    (ok 
        (var-set list-day-21 

            (unwrap-panic (as-max-len? (append (var-get list-day-21) new-num) u5))
        )   
    )
)



;; Unwrap-err-panic -> Optionsl & response

;; Try! -> Optionals & response
(define-public (try-example (input (response uint uint))) 
    (ok 
        (try! input)
    )

;; >> (contract-call?  .claritybasicsiii try-example (ok u1))
;; (ok u1)
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;; Day 23 - Default-To With Tuples ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-constant test-tuple {
    user: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM,
    balance: u10,
    referral: none
})

(define-read-only (get-test-tuple) 
    (get user test-tuple)
)
(define-read-only (read-test-tuple) 
    test-tuple
)


(define-constant example-tuple {
    example-bool: true,
    example-num: none,
    example-string: none,
    example-principal: tx-sender
})

(define-read-only (read-example-tuple) 
    example-tuple

;; >> (contract-call?  .claritybasicsiii read-example-tuple)
;;{ example-bool: true, example-num: none, example-principal: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM, example-string: (some "example") }

)

(define-read-only (read-example-principal) 
    (get example-principal example-tuple)

;; >> (contract-call?  .claritybasicsiii read-example-principal)
;;'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM
)


(define-read-only (read-example-num) 
    (get example-num example-tuple)
)
(define-read-only (read-example-num2) 
    (default-to u10 (get example-num example-tuple))

;; >> (contract-call?  .claritybasicsiii read-example-num2)
;; u10
    
)

(define-read-only (read-example-string) 
    (get example-string example-tuple)
)
(define-read-only (read-example-string2) 
   (default-to "Dipak Sharma" (get example-string example-tuple))

;; >> (contract-call?  .claritybasicsiii read-example-string2)
;; "Dipak Sharma"
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Day 24 - Core Conditionals II : Match/If  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-read-only (if-example (test-bool bool)) 
    (if test-bool
      ;; Evaluate to true
      "Its true."
      ;; Evaluate to false
      "Its false."
    )

;; >> (contract-call?  .claritybasicsiii if-example true)
;; "Its true."      
)


(define-read-only (if-example-num (num uint)) 
    (if  (and (> num u0) (< num u10))
    ;; Evaluate to true
        num 
        ;; Evaluate to false
       u10
    )
)



(define-read-only (match-example) 
    (match (some u1) 
        ;; Some value / there was some optional
        match-value (+ u1 match-value) 
        ;; None value / there was no optional
        u0
    )


;; >> (contract-call?  .claritybasicsiii match-example)
;; u2
)


(define-read-only (match-optional (test-value (optional uint))) 
    (match test-value
        match-value (+ u2 match-value)
        u0
    )

;; >> (contract-call?  .claritybasicsiii match-optional (some u10))
;; u12
)


(define-read-only (match-response (test-value (response uint uint))) 
    (match test-value
        ok-value ok-value
        err-value u0
     )

;; >> (contract-call?  .claritybasicsiii match-response (ok u5))
;; u5
)



;;;;;;;;;;;;;;;;;;;;;;;;  Day 25 - Introduction To Maps I ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-map first-map principal (string-ascii 24))


;; Set Map
(define-public (set-first-map (username (string-ascii 24))) 
    (ok 
        (map-set first-map tx-sender username)
    )

;; >> (contract-call?  .claritybasicsiii set-first-map "Dipak")
;; (ok true)
)

;; Get Map
(define-read-only (get-first-map) 
    (map-get? first-map tx-sender)

;; >> (contract-call?  .claritybasicsiii get-first-map)
;; (some "Dipak")
)


;; Map with tuple
(define-map second-map principal {
    username: (string-ascii 24),
    balance: uint,
    referral: (optional principal)
})

(define-public (set-second-map (new-username (string-ascii 24)) (new-balance uint) (new-referral (optional principal))) 
    (ok 
        (map-set second-map tx-sender {
            username: new-username,
            balance: new-balance,
            referral: new-referral
        })

    )

;; >> (contract-call?  .claritybasicsiii set-second-map "Dipak" u20 none)
;; (ok true)
)


(define-read-only (get-second-map) 
    (map-get? second-map tx-sender)


;; >> (contract-call?  .claritybasicsiii get-second-map)
;; (some { balance: u20, referral: none, username: "Dipak" })

)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Day 26 - Introduction To Maps II  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Insert Map

(define-public (insert-first-map (username (string-ascii 24))) 
    (ok 
        (map-insert first-map tx-sender username)
    )
)



(define-map third-map {user: principal, cohort: uint} {
    username: (string-ascii 24),
    balance: uint,
    referral: (optional principal)
})

(define-public (set-third-map (new-username (string-ascii 24)) (new-balance uint) (new-referral (optional principal))) 
    (ok 
        (map-set third-map {user:tx-sender, cohort:u1} {
            username: new-username,
            balance: new-balance,
            referral: new-referral
        })

    )

;; >> (contract-call?  .claritybasicsiii set-third-map "Dipak" u50 none)
;; (ok true)
)

(define-public (delete-third-map) 
    (ok 
        (map-delete third-map {user: tx-sender, cohort: u1})
    )

;; >> (contract-call?  .claritybasicsiii delete-third-map)
;; (ok true)
)

(define-read-only (get-third-map) 
    (map-get? third-map {user: tx-sender, cohort: u1})

;; >> (contract-call?  .claritybasicsiii get-third-map)
;;  (some { balance: u50, referral: none, username: "Dipak" })
)



