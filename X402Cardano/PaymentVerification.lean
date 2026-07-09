-- ============================================================
-- x402-Cardano: Payment Verification Formal Proofs
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Cardano / eUTXO / Minswap v2
-- ============================================================
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Logic.Basic

namespace X402Cardano

structure UTXORef where
  tx_hash : Nat; tx_index : Nat
  deriving Repr, DecidableEq

structure PaymentAuth where
  utxo       : UTXORef  -- input UTXO being consumed
  amount     : Nat       -- lovelace
  ttl_slot   : Nat       -- transaction TTL
  policy_id  : Nat       -- native token policy
  deriving Repr, DecidableEq

structure FacilitatorState where
  spent_utxos  : Finset UTXORef
  current_slot : Nat
  deriving Repr

def not_expired (a : PaymentAuth) (s : FacilitatorState) : Prop := s.current_slot ≤ a.ttl_slot
def nonce_fresh (a : PaymentAuth) (s : FacilitatorState) : Prop := a.utxo ∉ s.spent_utxos
def amount_positive (a : PaymentAuth) : Prop := 0 < a.amount
def verify (a : PaymentAuth) (s : FacilitatorState) : Prop :=
  not_expired a s ∧ nonce_fresh a s ∧ amount_positive a

theorem replay_prevented (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : a.utxo ∉ s.spent_utxos := h.2.1
theorem within_expiry (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : s.current_slot ≤ a.ttl_slot := h.1
theorem positive_amount (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : 0 < a.amount := h.2.2

def settle (a : PaymentAuth) (s : FacilitatorState) : FacilitatorState :=
  { s with spent_utxos := s.spent_utxos ∪ {a.utxo} }

theorem settled_nonce_used (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.utxo ∈ (settle a s).spent_utxos := by
  simp [settle, Finset.mem_union, Finset.mem_singleton]

theorem post_settlement_replay_blocked (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.utxo ∈ (settle a s).spent_utxos ∧ ¬a.utxo ∉ (settle a s).spent_utxos := by
  constructor
  · exact settled_nonce_used a s h
  · simp [settle, Finset.mem_union, Finset.mem_singleton]

end X402Cardano
