
;; Day 37 - Outlining Sections & Defining Cons/Vars/Maps
;; title: offspring-will
;; Smart contract that allows parents to create & fund wallets unlockable onlt by an assigned off-spring
;; By 0xdipak



;; Offspring Wallet
;; This is our main map that is created & funded by parents, & only unlockable by an assigned offspring (principal)
;; Principal -> {offspring-principal: principal, offspring-dob: uint, balance: uint}

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Cons,Vars & Maps ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

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






;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Read Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; parent Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Offspring Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Admin Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
