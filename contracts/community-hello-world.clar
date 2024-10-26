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


;;;;;;;;;;;;;;;;;;;;;
;; Write Functions ;;
;;;;;;;;;;;;;;;;;;;;;

