;; Performance Tracking Contract
;; Tracks vendor performance metrics over time

(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_INVALID_RATING (err u301))
(define-constant ERR_CONTRACT_NOT_FOUND (err u302))

;; Data structures
(define-map performance-contracts
  uint
  {
    vendor: principal,
    procurement-manager: principal,
    contract-value: uint,
    start-date: uint,
    end-date: uint,
    status: (string-ascii 20)
  }
)

(define-map performance-metrics
  {contract-id: uint, metric-type: (string-ascii 50)}
  {
    score: uint,
    recorded-date: uint,
    recorder: principal,
    notes: (string-ascii 200)
  }
)

(define-map vendor-performance-summary
  principal
  {
    total-contracts: uint,
    completed-contracts: uint,
    average-quality-score: uint,
    average-delivery-score: uint,
    average-communication-score: uint,
    last-updated: uint
  }
)

(define-data-var contract-id-nonce uint u0)

;; Public functions
(define-public (create-performance-contract
  (vendor principal)
  (contract-value uint)
  (end-date uint)
)
  (let (
    (contract-id (+ (var-get contract-id-nonce) u1))
    (manager tx-sender)
  )
    (var-set contract-id-nonce contract-id)
    (map-set performance-contracts contract-id {
      vendor: vendor,
      procurement-manager: manager,
      contract-value: contract-value,
      start-date: block-height,
      end-date: end-date,
      status: "active"
    })
    (ok contract-id)
  )
)

(define-public (record-performance-metric
  (contract-id uint)
  (metric-type (string-ascii 50))
  (score uint)
  (notes (string-ascii 200))
)
  (let ((contract-data (unwrap! (map-get? performance-contracts contract-id) ERR_CONTRACT_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get procurement-manager contract-data)) ERR_UNAUTHORIZED)
    (asserts! (<= score u100) ERR_INVALID_RATING)

    (map-set performance-metrics {contract-id: contract-id, metric-type: metric-type} {
      score: score,
      recorded-date: block-height,
      recorder: tx-sender,
      notes: notes
    })

    ;; Update vendor performance summary
    (update-vendor-performance-summary (get vendor contract-data))
    (ok true)
  )
)

(define-public (complete-contract (contract-id uint))
  (let ((contract-data (unwrap! (map-get? performance-contracts contract-id) ERR_CONTRACT_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get procurement-manager contract-data)) ERR_UNAUTHORIZED)

    (map-set performance-contracts contract-id
      (merge contract-data {status: "completed"})
    )
    (ok true)
  )
)

;; Private functions
(define-private (update-vendor-performance-summary (vendor principal))
  (let (
    (current-summary (default-to
      {total-contracts: u0, completed-contracts: u0, average-quality-score: u0,
       average-delivery-score: u0, average-communication-score: u0, last-updated: u0}
      (map-get? vendor-performance-summary vendor)
    ))
  )
    (map-set vendor-performance-summary vendor
      (merge current-summary {
        total-contracts: (+ (get total-contracts current-summary) u1),
        last-updated: block-height
      })
    )
    true
  )
)

;; Read-only functions
(define-read-only (get-performance-contract (contract-id uint))
  (map-get? performance-contracts contract-id)
)

(define-read-only (get-performance-metric (contract-id uint) (metric-type (string-ascii 50)))
  (map-get? performance-metrics {contract-id: contract-id, metric-type: metric-type})
)

(define-read-only (get-vendor-performance-summary (vendor principal))
  (map-get? vendor-performance-summary vendor)
)

(define-read-only (get-current-contract-id)
  (var-get contract-id-nonce)
)
