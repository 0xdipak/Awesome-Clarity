
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Cons, Vars & Maps ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Map that keeps track of a single track
(define-map track { artist: principal, album: (string-ascii 24), track-id: uint } { 
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Read Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Write Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Admin Functions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;