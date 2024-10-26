;; title: community-hello-world
;; contract that provides a simple community billboard, readable by anyone but only only updateable by admin permission

;;;;;;;;;;;;;;;;;;;;;;;;
;; Cons, Vars, & Maps ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Constants that sets deployer principal as admin
(define-constant admin tx-sender)


;; Varible that keeps track of the next user that'll introduce theselves / write to the billboard
(define-data-var next-user principal tx-sender)


;; Varibale tuple that contains new member info
(define-data-var billboard {new-user-principal: principal, new-user-name:(string-ascii 24)} {
    new-user-principal: tx-sender,
    new-user-name: ""
})



;;;;;;;;;;;;;;;;;;;;
;; Read Functions ;;
;;;;;;;;;;;;;;;;;;;;


;; get community billboard
(define-read-only (get-billboard) 
    (var-get billboard)
)

;; Get next user
(define-read-only (get-next-user) 
    (var-get next-user)
)


;;;;;;;;;;;;;;;;;;;;;
;; Write Functions ;;
;;;;;;;;;;;;;;;;;;;;;

;; Update Billboard
;; @desc - function used by next-user to update the community billboard
;; @param - new-user-name: (string-ascii 24)
(define-public (update-billboard (updated-user-name (string-ascii 24))) 

    (begin 
    ;; Assert that tx-sender is next-user(approved by admin)


    ;; Assert that updated-user-name is not empty

    ;; Var-set billboard with new keys

    (ok true)
    )
)


;; Admin set new-user
;; @desc - function used by admin to set / give permission to next user
;; @param - updated-user-principal: principal
(define-public (admin-set-new-uset (updated-user-principal principal)) 
    (begin 

        ;; Asset that tx-sender is admin


        ;; Assert that updated-user-principal is not admin


        ;; Assert that updated-uset-principal is not current next-user


        ;; Var-set next-user with updated-user-principal

    
    (ok true)
    )
)

