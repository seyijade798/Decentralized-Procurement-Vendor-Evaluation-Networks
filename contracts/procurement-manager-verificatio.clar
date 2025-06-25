;; Procurement Manager Verification Contract
;; Manages verification and registration of procurement managers

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_FOUND (err u102))

;; Data structures
(define-map procurement-managers
  principal
  {
    verified: bool,
    organization: (string-ascii 100),
    verification-date: uint,
    verifier: principal
  }
)

(define-map pending-verifications
  principal
  {
    organization: (string-ascii 100),
    requested-date: uint
  }
)

;; Public functions
(define-public (request-verification (organization (string-ascii 100)))
  (let ((manager tx-sender))
    (asserts! (is-none (map-get? procurement-managers manager)) ERR_ALREADY_VERIFIED)
    (map-set pending-verifications manager {
      organization: organization,
      requested-date: block-height
    })
    (ok true)
  )
)

(define-public (verify-manager (manager principal) (organization (string-ascii 100)))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-some (map-get? pending-verifications manager)) ERR_NOT_FOUND)
    (map-delete pending-verifications manager)
    (map-set procurement-managers manager {
      verified: true,
      organization: organization,
      verification-date: block-height,
      verifier: tx-sender
    })
    (ok true)
  )
)

;; Read-only functions
(define-read-only (is-verified-manager (manager principal))
  (match (map-get? procurement-managers manager)
    manager-data (get verified manager-data)
    false
  )
)

(define-read-only (get-manager-info (manager principal))
  (map-get? procurement-managers manager)
)

(define-read-only (get-pending-verification (manager principal))
  (map-get? pending-verifications manager)
)
