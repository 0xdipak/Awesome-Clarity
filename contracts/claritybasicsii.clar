;; clarity-basics-ii
;;  Day 8 - Optionals & Parameters

(define-read-only (show-some-i) 
    (some u2)
)

(define-read-only (show-none-i) 
    none
)


(define-read-only (params (num uint) (string (string-ascii 48)) (boolean bool )) 
    num
)

(define-read-only (params-optional (num (optional uint)) (string (optional (string-ascii 48))) (boolean (optional bool))) 
    string

)


;; Day 9 - Optionals Continued

(define-read-only (is-some-example (num (optional uint))) 
    (is-some num)
)

(define-read-only (is-none-example (num (optional uint))) 
    (is-none num)
)

(define-read-only (params-optional-and (num (optional uint)) (string (optional (string-ascii 48))) (boolean (optional bool))) 
    (and 
        (is-some num)
        (is-some string)
        (is-some boolean)
    )

;; >> (contract-call? .claritybasicsii params-optional-and (some u10) (some "Dipak") none)
;; false

;; >> (contract-call? .claritybasicsii params-optional-and (some u10) (some "Dipak") (some true))
;; true
)






;; Day 10 -  Introduction To Cons & Vars I

(define-constant fav-num u10)
(define-constant fav-string "Dipak")

(define-read-only (show-constant) 
    fav-num
;; >> (contract-call? .claritybasicsii show-constant)
;; u10
)

(define-read-only (show-constant-double) 
    (* fav-num u2)
;; >> (contract-call? .claritybasicsii show-constant-double)
;; u20
)



(define-data-var fav-num-var uint u10)
(define-data-var your-name (string-ascii 24) " Dipak")

(define-read-only (show-var) 
    (var-get fav-num-var)
;; >> (contract-call? .claritybasicsii show-var)
;;u10
)

(define-read-only (show-var-double) 
    (* u2 (var-get fav-num-var))
;; >> (contract-call? .claritybasicsii show-var-double)
;; u20
)

(define-read-only (show-name) 
    (concat "Hi," (var-get your-name))
;; >> (contract-call? .claritybasicsii show-name)
;; "Hi, Dipak"
)



;; Public Functions & Responses

(define-read-only (response-example) 
    (ok u10)
)

(define-public (change-name (new-name (string-ascii 24))) 
    (ok (var-set your-name new-name))

;; >> (contract-call? .claritybasicsii change-name "Dipak")
;; (ok true)
)



;; Tuples and Merge


(define-read-only (read-tuple-i) 
    {
        user-principal: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM,
        user-name: "Dipak",
        user-bal: u50
    }

;; >> (contract-call? .claritybasicsii read-tuple)
;; { user-bal: u50, user-name: "Dipak", user-principal: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM }

)


(define-public (write-tuple-i (new-user-principal principal) (new-user-name (string-ascii 24)) (new-user-bal uint) ) 
    (ok {
        user-principal: new-user-principal,
        user-name: new-user-name,
        user-bal: new-user-bal
    })

;; >> (contract-call? .claritybasicsii write-tuple-i 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 "Ram" u100)
 ;;(ok { user-bal: u100, user-name: "Ram", user-principal: 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 })
)

(define-data-var original { user-principal: principal, user-name: (string-ascii 24), user-bal: uint}  
    {
        user-principal: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM,
        user-name: "Dipak",
        user-bal: u50
    }

)

(define-read-only (read-original) 
    (var-get original)
)

(define-public (merge-principal (new-user-principal principal)) 
    (ok (merge 
        (var-get original)
        {user-principal: new-user-principal}
    ))
)

(define-public (merge-username (new-user-name (string-ascii 24))) 
    (ok 
        (merge 
            (var-get original)
            {user-name: new-user-name}
        )
    )
)

(define-public (merge-bal (new-balance uint)) 
    (ok 
        (merge 
            (var-get original)
            {user-bal: new-balance}
        )
    )
)


(define-public (merge-all (new-user-principal principal) (new-user-name (string-ascii 24)) (new-user-bal uint) ) 
    (ok 
        (merge
            (var-get original) 
            {
                user-principal: new-user-principal,
                user-name: new-user-name,
                user-bal: new-user-bal
            }
        )
    )

;; >> (contract-call? .claritybasicsii merge-all 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 "Ram Tharu" u100)
;; (ok { user-bal: u100, user-name: "Ram Tharu", user-principal: 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 })

)


;; Day 13 - Introduction To Keywords (tx-sender)

(define-read-only (show-tx-sender) 
    tx-sender

;; >> (contract-call? .claritybasicsii show-tx-sender)
;; 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM 
)

(define-constant admin 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

(define-read-only (is-admin) 
    (is-eq admin tx-sender)

;; >> (contract-call?  .claritybasicsii is-admin)
;; true
)






