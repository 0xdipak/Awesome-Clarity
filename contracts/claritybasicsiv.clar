
;; title: claritybasicsiv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Day 26.5 - The All Powerful Let  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define-data-var counter uint u0)
(define-map counter-history uint {user: principal, count: uint})

(define-public (increase-count-begin (increase-by uint)) 
        (begin 
            ;; Assert that tx-sender is not previous counter-history user
            (asserts! (not (is-eq (some tx-sender) (get user (map-get? counter-history (var-get counter))))) (err u0))

            ;; Var-set counter-history
            (map-set counter-history (var-get counter) {
                user: tx-sender,
                count: (+ increase-by (get count (unwrap! (map-get? counter-history (var-get counter)) (err u1))))
            })

            ;; Var-set increase counter
            (ok (var-set counter (+ (var-get counter) u1)))
        )
)

(define-public (increase-count-let (increase-by uint)) 
    (let 
        (
            ;; local variables
            (current-counter (var-get counter))
            (current-counter-history (default-to {user: tx-sender, count: u0} (map-get? counter-history current-counter)))
            (previous-counter-user (get user current-counter-history))
            (previous-count-amount (get count current-counter-history))
        )
        ;; Assert that tx-sender is not previous counter-history user
        (asserts! (not (is-eq tx-sender previous-counter-user)) (err u0))

        ;; Var-set counter-history
        (map-set counter-history current-counter {
            user: tx-sender,
            count: (+ increase-by previous-count-amount)
        })

        ;; Var-set
        (ok (var-set counter (+ u1 current-counter)))
    )
)


;; Day 32 - Syntax

;; Trailing (heavy parenthesis that trail)
;; Encapsulated (heighlights internal functions)


(define-public (increase-count-trailing (increase-by uint)) 
    (begin 
        ;; Assert that tx-sender is not previous counter-history user
        (asserts! 
            (not (is-eq 
                (some tx-sender) (get user (map-get? counter-history (var-get counter))))) (err u0))

        (ok (var-set counter (+ (var-get counter) u1)))
    )
)



(define-public (increase-count-encapsulation (increase-by uint)) 
    (begin 
        ;; Assert that tx-sender is not previous counter-history user
        (asserts! 
            (not (is-eq 
                    (some tx-sender) 
                    (get user 
                        (map-get? counter-history (var-get counter)))
            )) 
            (err u0)
        )

        (ok 
            (var-set counter 
                (+ 
                    (var-get counter) 
                    u1
                )
            )
        )
    )
)




;; Day 33 - STX Transfer

(define-public (send-stx-single) 
    (stx-transfer? u100000 tx-sender 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG)
)


(define-public (send-stx-double) 
    (begin 
        (unwrap! (stx-transfer? u100000 tx-sender 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG) (err u0))
        (stx-transfer? u100000 tx-sender 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5)
    )
)


;; Day 34 - Other STX Functions

(define-read-only (balance-of) 
 (stx-get-balance tx-sender)

;; >> (contract-call?  .claritybasicsiV balance-of)
;; u100000000000000
)


(define-public (send-stx-balance) 

 (stx-transfer? (stx-get-balance tx-sender) tx-sender 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG)
)


(define-public (burn-some (amout uint)) 
    (stx-burn? amout tx-sender)
)

(define-public (burn-half-of-balance) 
    (stx-burn? (/ (stx-get-balance tx-sender) u2) 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
)

;;