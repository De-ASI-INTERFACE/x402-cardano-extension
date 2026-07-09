-- x402-Cardano | Author: Richard Patterson
import Mathlib.Data.Finset.Basic
namespace X402Cardano
structure UTXOPayment where
  tx_hash : Nat; tx_index : Nat; amount : Nat; ttl_slot : Nat
  deriving Repr
structure LedgerState where
  spent_utxos : Finset (Nat × Nat); current_slot : Nat
  deriving Repr
def utxo_unspent (p : UTXOPayment) (s : LedgerState) : Prop :=
  (p.tx_hash, p.tx_index) ∉ s.spent_utxos
def not_expired (p : UTXOPayment) (s : LedgerState) : Prop :=
  s.current_slot ≤ p.ttl_slot
def verify (p : UTXOPayment) (s : LedgerState) : Prop :=
  utxo_unspent p s ∧ not_expired p s
theorem cardano_utxo_unique (p : UTXOPayment) (s : LedgerState)
    (h : verify p s) : (p.tx_hash, p.tx_index) ∉ s.spent_utxos := h.1
end X402Cardano
