
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

;; Min. Offspring wallet funds amount
(define-constant min-create-wallet-amount u5000000)

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
;; Day 40 - Outlining Public Functions II
;; Day 41 - Implementing Public Functions I
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
            (current-total-fees (var-get total-fee-earned))
            (new-total-fees (+ current-total-fees create-wallet-fee))
        )

        ;; Assert that map-get? offspring-wallet is-none
        (asserts! (is-none (map-get? offspring-wallet tx-sender)) (err "err-wallet-already-exists"))

        ;; Assert that new-offspring-dob is at least higher than block-height - 18 years of blocks
        ;; (asserts! (> new-offspring-dob (- block-height eighteen-years-in-block-height)) (err "err-past-18-years"))

        ;; Assert that new-offspring-principal is not an admin or tx-sender
        (asserts! (or (not (is-eq tx-sender new-offspring-principal)) (is-none (index-of? (var-get admins) new-offspring-principal))) (err "err-invalid-offspring-principal"))

        ;; Pay create-wallet-fee in stx (5STX)
        (unwrap! (stx-transfer? create-wallet-fee tx-sender deployer) (err "err-stx-transfer"))

        ;; Var-set total-fees
        (var-set total-fee-earned new-total-fees)

        ;; Map-set offspring-wallet
        (ok (map-set offspring-wallet tx-sender {
            offspring-principal: new-offspring-principal,
            offspring-dob: new-offspring-dob,
            balance: u0
        }))
        
    )
)

;; Fund wallet
;; @desc - allows anyone to fund an exisiting wallet
;; @param -  parent: principal, amount: uint
(define-public (fund-wallet (parent principal) (amount uint)) 
    (let 
        (
            ;; local vars
            (current-offspring-wallet (unwrap! (map-get? offspring-wallet parent) (err "err-no-offspring-wallet")))
        ) 

        ;; Assert that amount is higher tha min-add-wallet-amount (5 STX)

        ;; Send stx (amount-fee) to contract

        ;; Send stx(fee) to deployer

        ;; Var-set total-fees

        ;; Map-set current offspring-wallet by merging with old balance + amount
        (ok true)
    )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Offspring Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Claim wallet
;; @desc - allows offspring to claim wallet once & once only
;; @param -  parent: principal
(define-public (claim-wallet (parent principal)) 
    (let 
        (
            ;; Local vars
            (current-offspring-wallet (unwrap! (map-get? offspring-wallet parent) (err "err-no-offspring-wallet")))
        ) 

        ;; Assert that tx-sender is-eq to offspring-principal

        ;; Assert that block-height is 18 years in block later than offspring-dob

        ;; Send stx (amount - withdrawl fee) to offspring

        ;; Send stx withdrawal to deployer

        ;; Delete offspring-wallet map

        ;; Update total-fees-earned
        (ok true)
    )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Emergency Withdrawal ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emergency claim
;; @desc - Allows either or an admin to withdraw all stx (- emergency withdraw fee), back to parent & remove wallet
;; @param - parent: principal
(define-public (emergancy-claim (parent principal)) 
    (let 
        (
            ;; Local vars
            (current-offspring-wallet (unwrap! (map-get? offspring-wallet parent) (err "err-no-offspring-wallet")))
        ) 

        ;; Assert that tx-sender is either parent or tx-sender is one of the admins

        ;; Assert that block-height is less than 18 years from DOB

        ;; Send stx (amount - emergency-withdrawl fee) to offspring

        ;; Send stx emergency-withdrawal to deployer

        ;; Delete offspring-wallet map

        ;; Update total-fees-earned
        (ok true)
    )
)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Admin Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add admin
;; @desc - function to add an admin to existing admin list
;; @param - new-admin: principal
(define-public (add-admin) 
    (let 
        (
            ;; Local vars
        )

        ;; Assert that tx-sender is a current admin

        ;; Assert that new-admin does not exists in list of admins

        ;; Append new admin to list of admins
        (ok true)
    )
)

;; Remove admin
;; @desc - functions to remove an exisitng admin
;; @param - remove-admin : principal
(define-public (remove-admin) 
    (let 
        (
            ;; Local vars
        )

        ;; Assert that tx-sender is a current admin

        ;; Filter remove removed-admin
        (ok true)
    )
)