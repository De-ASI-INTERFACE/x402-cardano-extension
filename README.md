# x402-Cardano Extension
**HTTP 402 Payment-Gated Routing on Cardano**
**Author:** Richard Patterson (@De-ASI-INTERFACE) | **Version:** 1.0.0 | **Date:** 2026-07-09 | **License:** MIT

## Overview
The x402-Cardano Extension adapts the x402 HTTP 402 payment standard to Cardano using eUTXO (extended UTXO) model, Plutus V3 smart contracts, and CIP-30 wallet connector signing. It defines `scheme: cardano-ada` for native ADA payments and `scheme: cardano-cip68` for CIP-68 multi-asset token payments, with Minswap v2 as the canonical DEX routing surface. The eUTXO payment gate is enforced as a Plutus spending validator that checks datum-encoded authorization before allowing UTXOs to be consumed. Lean 4 proofs verify UTXO uniqueness, TTL expiry, and datum integrity invariants.
**Reference ID:** RP-DEASI-ADA-2026-0709-001
