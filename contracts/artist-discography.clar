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


;; Map that keeps track of a single track
(define-map track { artist: principal, album-id: uint, track-id: uint } { 
    title: (string-ascii 24),
    dutation: uint,
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



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Write Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add a track
;; @desc - function that allows a user or admin to add a track.
;; @params - title (string-ascii 24), duration (uint), featured-artist (optional principal), album-id (uint)
(define-private (add-a-track (artist principal) (title (string-ascii 24)) (duration uint) (featured (optional principal)) (album-id uint)) 
    (let 
        (
           (test u0)
        )

        ;; Assert that tx-sender is either artist or admin

        ;; Assert that album exists in discography

        ;; Assert that duration is less than 600 (10 mins)

        ;; Map-set new track

        ;; Map-set append track to album

        (ok test)
    )
)



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Admin Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add admin
;; Remove