;; title: community-hello-world
;; contract that provides a simple community billboard, readable by anyone but only only updateable by admin permission

;;;;;;;;;;;;;;;;;;;;;;;;
;; Cons, Vars, & Maps ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Constants that sets deployer principal as admin
(define-constant admin tx-sender)

;; Error messages
(define-constant ERR-TX-SENDER_NOT_NEXT_USER (err u0))


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

;; >> (contract-call?  .community-hello-world  get-billboard)
;; { new-user-name: "Ram Thapa", new-user-principal: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM }
)

;; Get next user
(define-read-only (get-next-user) 
    (var-get next-user)

;;>> (contract-call?  .community-hello-world  get-next-user)
;; 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
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
    (asserts! (is-eq tx-sender (var-get next-user)) ERR-TX-SENDER_NOT_NEXT_USER)


    ;; Assert that updated-user-name is not empty
    (asserts! (not (is-eq updated-user-name "")) (err u1))

    ;; Var-set billboard with new keys
    (ok (var-set billboard {
            new-user-principal: tx-sender,
            new-user-name: updated-user-name
        }))
    )

;; >> (contract-call?  .community-hello-world  update-billboard "Ram Thapa")
;; (ok true)
)


;; Admin set new-user
;; @desc - function used by admin to set / give permission to next user
;; @param - updated-user-principal: principal
(define-public (admin-set-new-user (updated-user-principal principal)) 
    (begin 

        ;; Asset that tx-sender is admin
        (asserts! (is-eq tx-sender admin) (err u2))


        ;; Assert that updated-user-principal is not admin
        (asserts! (not (is-eq tx-sender updated-user-principal)) (err u3))


        ;; Assert that updated-user-principal is not current next-user
        (asserts! (not (is-eq updated-user-principal (var-get next-user))) (err u4))


        ;; Var-set next-user with updated-user-principal
        (ok (var-set next-user updated-user-principal))
    )

;;>> (contract-call?  .community-hello-world  admin-set-new-user 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG)
;; (ok true)
)


;; Go to https://explorer.hiro.so/sandbox/deploy?chain=mainnet
;; Copy paste your contract and deploay to mainnet

;; I successfully deployed my first smart contract to stcks mainnet with name "hello-world-community-explorer"
;; You can see my contract here : https://explorer.hiro.so/txid/0x320cf8161138ebbe92394ceb606a5cb5343127f3939b360f475b8489f5381bd7?chain=mainnet



;; ;;;;;;;;;;;;;;;;;;;;;;;; STX-CLI ;;;;;;;;;;;;;;;;;;;;;;;

;; stx help

;; To create a new account
;; stx make_keychain

;; To deploy contract
;; stx deploy_contract source_file.clar contract_name fee(micro_stx) nonce(0) Private_key