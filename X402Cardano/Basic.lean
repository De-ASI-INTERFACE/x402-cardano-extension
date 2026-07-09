-- ============================================================
-- x402-Cardano: Basic Re-export Shim
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Cardano / eUTXO / Minswap v2
--
-- Re-exports X402Cardano.PaymentVerification as the single
-- authoritative source of all shared types and definitions.
-- Chain-prefixed theorem aliases are provided for ergonomic use.
--
-- Note: Cardano uses the eUTXO model. The replay nonce is a
-- UTXORef (tx_hash × tx_index), not a Nat. The Finset of
-- spent UTXOs enforces single-spend. spent_utxos : Finset UTXORef.
-- ============================================================
import X402Cardano.PaymentVerification

namespace X402Cardano

/-- Alias: eUTXO double-spend prevention under the Cardano chain prefix.
    result type: a.utxo ∉ s.spent_utxos, where utxo : UTXORef. -/
theorem cardano_replay_prevented
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.utxo ∉ s.spent_utxos :=
  replay_prevented a s h

/-- Alias: TTL slot expiry enforcement under the Cardano chain prefix.
    Delegates to within_expiry: s.current_slot ≤ a.ttl_slot. -/
theorem cardano_not_expired
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.current_slot ≤ a.ttl_slot :=
  within_expiry a s h

end X402Cardano
