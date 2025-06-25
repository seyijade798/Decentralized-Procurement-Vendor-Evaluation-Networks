# Decentralized Procurement Vendor Evaluation Networks

A comprehensive blockchain-based system for managing vendor evaluation and procurement processes using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized, transparent, and auditable platform for procurement managers to evaluate, track, and select vendors based on multiple criteria including performance, risk assessment, and optimization algorithms.

## Architecture

The system consists of five interconnected smart contracts:

### 1. Procurement Manager Verification (`procurement-manager-verification.clar`)
- **Purpose**: Validates and manages procurement manager credentials
- **Key Features**:
    - Manager registration and verification workflow
    - Authorization controls for procurement activities
    - Verification status tracking

### 2. Vendor Assessment (`vendor-assessment.clar`)
- **Purpose**: Manages vendor registration and capability assessments
- **Key Features**:
    - Vendor registration with categories and details
    - Multi-criteria assessment scoring (technical, financial, compliance)
    - Capability tracking (services, certifications, experience)

### 3. Performance Tracking (`performance-tracking.clar`)
- **Purpose**: Tracks vendor performance across contracts
- **Key Features**:
    - Contract creation and management
    - Performance metrics recording (quality, delivery, communication)
    - Historical performance summaries

### 4. Risk Evaluation (`risk-evaluation.clar`)
- **Purpose**: Evaluates and monitors vendor risks
- **Key Features**:
    - Multi-dimensional risk assessment (financial, operational, compliance, reputation)
    - Risk incident reporting and tracking
    - Risk level calculations (Low, Medium, High, Critical)

### 5. Selection Optimization (`selection-optimization.clar`)
- **Purpose**: Optimizes vendor selection using weighted criteria
- **Key Features**:
    - Customizable selection criteria with weights
    - Weighted scoring algorithms
    - Vendor recommendation system

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd procurement-network
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks blockchain:

\`\`\`bash
# Deploy procurement manager verification
clarinet deploy --contract procurement-manager-verification

# Deploy vendor assessment
clarinet deploy --contract vendor-assessment

# Deploy performance tracking
clarinet deploy --contract performance-tracking

# Deploy risk evaluation
clarinet deploy --contract risk-evaluation

# Deploy selection optimization
clarinet deploy --contract selection-optimization
\`\`\`

## Usage Examples

### 1. Manager Verification Process

\`\`\`clarity
;; Request verification as a procurement manager
(contract-call? .procurement-manager-verification request-verification "Tech Corp")

;; Verify manager (owner only)
(contract-call? .procurement-manager-verification verify-manager 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 "Tech Corp")
\`\`\`

### 2. Vendor Registration and Assessment

\`\`\`clarity
;; Register as a vendor
(contract-call? .vendor-assessment register-vendor "TechVendor Inc" "Software")

;; Assess vendor capabilities
(contract-call? .vendor-assessment assess-vendor
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
u85 u90 u80 "Strong technical capabilities")
\`\`\`

### 3. Performance Tracking

\`\`\`clarity
;; Create performance contract
(contract-call? .performance-tracking create-performance-contract
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
u50000 u2000)

;; Record performance metrics
(contract-call? .performance-tracking record-performance-metric
u1 "quality" u85 "Good quality delivery")
\`\`\`

### 4. Risk Assessment

\`\`\`clarity
;; Assess vendor risk
(contract-call? .risk-evaluation assess-vendor-risk
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
u2 u1 u2 u1)

;; Report risk incident
(contract-call? .risk-evaluation report-risk-incident
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
"security-breach" u3 "Data security incident")
\`\`\`

### 5. Selection Optimization

\`\`\`clarity
;; Set selection criteria
(contract-call? .selection-optimization set-selection-criteria
u30 u25 u20 u15 u10)

;; Evaluate vendor for selection
(contract-call? .selection-optimization evaluate-vendor-for-selection
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
u85 u90 u80 u75 u88)
\`\`\`

## Data Structures

### Risk Levels
- **1**: Low Risk
- **2**: Medium Risk
- **3**: High Risk
- **4**: Critical Risk

### Contract Status
- **"active"**: Contract in progress
- **"completed"**: Contract finished
- **"open"**: Procurement request open for bids

### Assessment Scores
All assessment scores use a 0-100 scale where:
- 0-40: Poor
- 41-60: Fair
- 61-80: Good
- 81-100: Excellent

## Testing

The project includes comprehensive test suites for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run specific contract tests
npm test procurement-manager-verification
npm test vendor-assessment
npm test performance-tracking
npm test risk-evaluation
npm test selection-optimization
\`\`\`

## Security Considerations

1. **Access Control**: Only verified procurement managers can perform certain operations
2. **Data Validation**: All inputs are validated for proper ranges and formats
3. **Authorization**: Contract owners and authorized users have specific permissions
4. **Immutable Records**: All assessments and performance data are permanently recorded

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the GitHub repository.

## Roadmap

- [ ] Integration with external data sources
- [ ] Advanced analytics and reporting
- [ ] Mobile application interface
- [ ] Multi-signature approval workflows
- [ ] Integration with traditional procurement systems
  \`\`\`

## API Reference

### Read-Only Functions

All contracts provide read-only functions for querying data without transaction costs:

- \`get-vendor-info(vendor: principal)\`
- \`get-manager-info(manager: principal)\`
- \`get-performance-contract(contract-id: uint)\`
- \`get-vendor-risk-profile(vendor: principal)\`
- \`get-selection-criteria(manager: principal)\`

### Events

The contracts emit events for important state changes that can be monitored by external applications.
