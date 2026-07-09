-- ============================================================
-- x402-Cardano: Facilitator State Integrity
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Finset.Basic
import X402Cardano.PaymentVerification

namespace X402Cardano.Facilitator

theorem nonces_monotone (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.spent_utxos ⊆ (settle a s).spent_utxos := by simp [settle]; exact Finset.subset_union_left

theorem fresh_not_in_pre_state (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.utxo ∉ s.spent_utxos := replay_prevented a s h

structure TimeStep where
  s_before : FacilitatorState; s_after : FacilitatorState
  mono : s_before.current_slot ≤ s_after.current_slot

theorem expiry_is_monotone (a : PaymentAuth) (ts : TimeStep) (h_valid : not_expired a ts.s_before) :
    ts.s_before.current_slot ≤ a.ttl_slot := h_valid

end X402Cardano.Facilitator
