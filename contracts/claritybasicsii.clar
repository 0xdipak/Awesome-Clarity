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









