
;; Day 37 - Outlining Sections & Defining Cons/Vars/Maps
;; title: offspring-will
;; Smart contract that allows parents to create & fund wallets unlockable onlt by an assigned off-spring
;; By 0xdipak


;; Offspring Wallet
;; This is our main map that is created & funded by parents, & only unlockable by an assigned offspring (principal)
;; Principal -> {offspring-principal: principal, offspring-dob: uint, balance: uint}
;; 1. Create wallet
;; 2. Fund wallet
;; 3. Claim wallet
    ;; A. Offspring
    ;; B. Parent/Admin

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Cons,Vars & Maps ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Deployer
(define-constant deployer tx-sender)

;; Contract
(define-constant contract (as-contract tx-sender))

;; Create Offspring wallet fee
(define-constant create-wallet-fee u5000000)

;; Add offspring wallet funds fee
(define-constant add-wallet-fund-fee u2000000)

;; Min. Offspring wallet funds fee
(define-constant min-create-wallet-fee u5000000)

;; Early withdrawal fee (10%)
(define-constant early-withdrawal-fee u10)

;; Normal withdrawal fee (2%)
(define-constant normal-withdrawal-fee u2)

;; 18 years in blockheight (18 years * 365 days * 144 blocks/day)
(define-constant  eighteen-years-in-block-height (* u18 (* u365 u144)))


;; Admin list of principal
(define-data-var admins (list 10 principal) (list tx-sender))

;; Total fees earned
(define-data-var total-fee-earned uint u0)

;; Offspring wallet
(define-map offspring-wallet principal { 
    offspring-principal: principal,
    offspring-dob: uint,
    balance: uint
 })





;; Day 38 - Implementing Read-Only
;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Read Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Get offspring wallet
(define-read-only (get-offspring-wallet (parent principal)) 
    (map-get? offspring-wallet parent)
)

;; Get offspring principal
(define-read-only (get-offspring-wallet-principal (parent principal)) 
   (get offspring-principal (map-get? offspring-wallet parent))
)

;; Get offspring wallet balance
(define-read-only (get-offspring-wallet-balance (parent principal)) 
    (default-to u0 (get balance (map-get? offspring-wallet parent)))
)

;; Get offspring DOB
(define-read-only (get-offspring-wallet-dob (parent principal)) 
   (get offspring-dob (map-get? offspring-wallet parent))
)

;; Get offspring wallet unlock height
(define-read-only (get-offspring-wallet-unlock-height (parent principal)) 
    (let 
        (
            ;; local vars
            (offspring-dob (unwrap! (get-offspring-wallet-dob parent) (err u1)))
        )
        ;; body
       (ok (+ offspring-dob eighteen-years-in-block-height))
    )
)

;; Get earned fees
(define-read-only (get-earned-fees) 
    (var-get total-fee-earned)
)


;;Get STX in contract
(define-read-only (get-contract-stx-balance) 
    (stx-get-balance contract)
)



;; Day 39 - Outlining Public Functions I
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Parent Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Create wallet
;; @desc - creates new offspring wallet with new parent (no initial deposit)
;; @param - new-offspring-principal: principal, new-offspring-dob: uint
(define-public (create-wallet (new-offspring-principal principal) (new-offspring-dob uint)) 
    (let 
        (
            ;; Local vars

        )

        ;; Assert that map-get? offspring-wallet is-none


        ;; Assert that new-offspring-dob is at least higher than block-height - 18 years of blocks

        ;; Map-set offspring-wallet
        (ok true)
    )
)

;; Fund wallet
;; @desc - allows anyone to fund an exisiting wallet
;; @param -  parent-principal: principal, amount: uint
(define-public (fund-wallet (parent-principal principal) (amount uint)) 
    (let 
        (
            ;; local vars
        ) 
        (ok true)
    )
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Offspring Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Admin Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
