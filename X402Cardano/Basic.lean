-- x402-Cardano Basic | Author: Richard Patterson (@De-ASI-INTERFACE)
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace X402Cardano

structure UTXOPayment where
  tx_hash  : Nat
  tx_index : Nat
  amount   : Nat
  ttl_slot : Nat
  deriving Repr, DecidableEq

structure LedgerState where
  spent_utxos  : Finset (Nat × Nat)
  current_slot : Nat
  deriving Repr

def verify (p : UTXOPayment) (s : LedgerState) : Prop :=
  (p.tx_hash, p.tx_index) ∉ s.spent_utxos ∧ s.current_slot ≤ p.ttl_slot

theorem cardano_utxo_unique (p : UTXOPayment) (s : LedgerState) (h : verify p s)
    : (p.tx_hash, p.tx_index) ∉ s.spent_utxos := h.1

theorem cardano_not_expired (p : UTXOPayment) (s : LedgerState) (h : verify p s)
    : s.current_slot ≤ p.ttl_slot := h.2

end X402Cardano
