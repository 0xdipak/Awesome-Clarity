;; Day 27 - Outlining Sections & Definine Cons/Vars
;; Artist Discography
;; Contracts that models an artist discography (discography -> albums -> tracks)

;; Discography
;; An artist discography is a list of albums
;; The artist or an admin can start a discography & can add/remove albums

;; Album
;; An album is a list of tracks + some additional info (such as when it was published)
;; The artist or an admin can start an album & can add/remove tracks


;; Track
;; A track is made up of name, duration(in sec) and a possible feature(optional feature)
;; The artist or an admin can start a track & can add/remove tracks


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Cons, Vars & Maps ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Admin list of principals
(define-data-var admins (list 10 principal) (list tx-sender))


;; Map that keeps track of a single track
(define-map track { artist: principal, album-id: uint, track-id: uint } { 
    title: (string-ascii 24),
    duration: uint,
    featured: (optional principal)
})


;; Map that keeps track of a single album
(define-map album { artist: principal, album-id: uint } { 
    title: (string-ascii 24),
    tracks: (list 20 uint),
    height-published: uint
})


;; Map that keeps track of a single discography
(define-map discography principal (list 10 uint))


;; Day 28 - Implementing Read-Only
;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Read Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Get track data
(define-read-only (get-track-data (artist principal) (album-id uint) (track-id uint)) 
    (map-get? track {artist: artist, album-id: album-id, track-id: track-id})
)

;; Get featured artist
(define-read-only (get-featured-artist (artist principal) (album-id uint) (track-id uint)) 
   (get featured (map-get? track {artist: artist, album-id: album-id, track-id: track-id}))
)

;; Get album data
(define-read-only (get-album-data (artist principal) (album-id uint)) 
    (map-get? album {artist: artist, album-id: album-id})
)

;; Get published
(define-read-only (get-album-published-height (artist principal) (album-id uint)) 
    (get height-published (map-get? album {artist: artist, album-id: album-id}))
)

;; Get discography
(define-read-only (get-discography (artist principal)) 
    (map-get? discography artist)
)



;; Day 29 - Outlining Public Functions
;; Day 30 - Implementing Public Functions
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Write Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add a track
;; @desc - function that allows a user or admin to add a track.
;; @params - title (string-ascii 24), duration (uint), featured-artist (optional principal), album-id (uint)
(define-public (add-a-track (artist principal) (title (string-ascii 24)) (duration uint) (featured (optional principal)) (album-id uint)) 
    (let 
        (
           (current-discography (unwrap! (map-get? discography artist) (err u0)))
           (current-album (unwrap! (index-of? current-discography album-id) (err u2)))
           (current-album-data (unwrap! (map-get? album {artist: artist, album-id: album-id}) (err u3)))
           (current-album-tracks (get tracks current-album-data))
           (current-album-track-id (len current-album-tracks))
           (next-album-track-id (+ u1 current-album-track-id))
        )

        ;; Assert that tx-sender is either artist or admin
        (asserts! (or (is-eq tx-sender artist) (is-some (index-of? (var-get admins) tx-sender))) (err u1))

        ;; Assert that duration is less than 600 (10 mins)
        (asserts! (< duration u600) (err u3))

        ;; Map-set new track
        (map-set track {artist: artist, album-id: album-id, track-id: next-album-track-id} {
            title: title,
            duration: duration,
            featured: featured
        })

        ;; Map-set album map by appending new track to album
        (ok (map-set album {artist: artist, album-id: album-id} 
            (merge 
                current-album-data
                {tracks: (unwrap! (as-max-len? (append current-album-tracks next-album-track-id) u10) (err u4))}

            )
        ))

    )
)

;; Add an album
;; @desc - function that allows the artist to add a new album or start a new discography & then add album

(define-public (add-album-or-create-discography-and-add-album (artist (optional principal)) (album-title (string-ascii 24))) 
    (let 
        (
            ;; local vars
        ) 

        ;; Check whether discography exists / if discography is-some

            ;; Discography exists


            ;; Discography does not exists
                ;; Map-set new discography


        ;; Map-set new album

        ;; Append new album to discography

        (ok true)
    )

)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Admin Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add admin
;; @desc - Function that an existing admin can call to add another admin
;; @parama - New admin (principal)
(define-public (add-admin (new-admin principal)) 
    (let 
        (
            (test u0)
        )

        ;; Assert that tx-sender ia an existing admin

        ;; Assert that new-admin does not exists in admin list

        ;; Append new-admin to admin list
        (ok test)
    ) 
    
)

;; Remove
;; @desc - Function that removes an existing admin
;; @params - Remove admin (principal)
(define-public (remove-admin (new-admin principal)) 
    (let 
        (
            (test u0)
        )

        ;; Assert that tx-sender is an existing admin

        ;; Assert that removes-admin is  existing in admin list

        ;; remove admin from admin list
        (ok test)
    ) 
    
)