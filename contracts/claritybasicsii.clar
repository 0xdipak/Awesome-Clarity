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



;; Day 14 - Introduction To Conditionals

(define-read-only (show-asserts (num uint)) 
(ok (asserts! (> num u2) (err u1)))

;; >> (contract-call?  .claritybasicsii show-asserts u3)
;; (ok true)
)


(define-constant err-too-large (err u1))
(define-constant err-too-small (err u2))
(define-constant err-not-auth (err u3))

(define-constant admin-one tx-sender)


(define-read-only (check-admin-i) 
    (ok (asserts! (is-eq tx-sender admin-one) err-not-auth))

;; >> (contract-call?  .claritybasicsii check-admin-i)
;; (ok true)
)


;; Day 15 - Using Begin

;; Set & say hello
;; Counter by even

(define-data-var hello-name (string-ascii 48) "Dipak")
;; @desc - This function allows a user to provide a name, which, if different, changes a name variable & returns "Hello new name"
;; @param - new-name: (string-ascii 48) that represents the new name

(define-public (set-and-say-hello (new-name (string-ascii 48))) 
    (begin 
        ;; Assert that name is not empty
        (asserts! (not (is-eq "" new-name)) (err u1))

        ;; Assert that name is not equal to current name
        (asserts! (not (is-eq (var-get hello-name) new-name)) (err u2))

        ;; Var-set new name
        (var-set hello-name new-name)

        ;; Say hello new name
      (ok (concat "Hello " (var-get hello-name)))
    )

;; >> (contract-call?  .claritybasicsii set-and-say-hello "rAM kUMAR")
;; (ok "Hello rAM kUMAR")
)

(define-read-only (read-hello-name) 
    (var-get hello-name)

;; >> (contract-call?  .claritybasicsii read-hello-name)
;; "Dipak"
)



(define-data-var counter uint u0)


(define-read-only (read-counter) 
    (var-get counter)
)

;; @desc - this func allows a user to increase the counter by only even number
;; @param - add-num: uint that user submits to add to counter

(define-public (increment-counter-event (add-num uint)) 
    (begin 
        ;; Assert that add-num
        (asserts! (is-eq u0 (mod add-num u2)) (err u3))

        ;; Increment & var-set counter
        (ok (var-set counter (+ (var-get counter) add-num)))
    )
)



