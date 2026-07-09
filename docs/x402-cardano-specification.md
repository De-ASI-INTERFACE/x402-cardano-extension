# x402-Cardano Specification
**Author:** Richard Patterson | **Ref:** RP-DEASI-ADA-2026-0709-001

## ADA Schema (`scheme: cardano-ada`)
```json
{ "scheme": "cardano-ada", "network": "mainnet",
  "sender": "addr1<bech32>", "facilitator": "addr1<bech32>",
  "amount": "<lovelace-u64>", "txHash": "<hex-tx-hash>",
  "txIndex": "<uint>", "ttl": "<slot-number>",
  "datum": "<plutus-datum-cbor>", "signature": "<cip30-sig>" }
```

## CIP-68 Schema (`scheme: cardano-cip68`)
```json
{ "scheme": "cardano-cip68", "policyId": "<hex>",
  "assetName": "<hex>", "amount": "<u64>",
  "sender": "addr1<bech32>", "facilitator": "addr1<bech32>",
  "ttl": "<slot-number>", "datum": "<plutus-datum-cbor>",
  "signature": "<cip30-sig>" }
```

## Cardano-Specific Invariants
1. **eUTXO Uniqueness:** Each UTXO identified by `(txHash, txIndex)` — consumed once globally
2. **TTL Slot Expiry:** Transaction invalid after slot TTL in ledger rules
3. **Plutus Datum Integrity:** Payment auth encoded in datum; validator checks before UTXO spend
4. **Deterministic Fees:** Fee calculated off-chain, encoded in tx; no gas surprises
5. **CIP-30 Signature:** Browser wallet connector signs payment authorization
