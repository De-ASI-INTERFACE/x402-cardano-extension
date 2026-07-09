-- ============================================================
-- x402-Cardano: Minswap v2 Routing Invariants
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Nat.Basic
import X402Cardano.PaymentVerification

namespace X402Cardano.Minswap

structure PoolDatum where
  asset_a : Nat; asset_b : Nat
  reserve_a : Nat; reserve_b : Nat
  deriving Repr

structure SwapRedeemer where
  pool     : PoolDatum
  amount_in : Nat
  min_amount_out : Nat
  deriving Repr

structure GatedSwap where
  auth : PaymentAuth; redeemer : SwapRedeemer
  deriving Repr

def route_authorized (gs : GatedSwap) (s : FacilitatorState) : Prop := verify gs.auth s
def route_sane (gs : GatedSwap) : Prop := 0 < gs.redeemer.min_amount_out ∧ gs.auth.amount = gs.redeemer.amount_in
def gated_swap_valid (gs : GatedSwap) (s : FacilitatorState) : Prop := route_authorized gs s ∧ route_sane gs

theorem gated_swap_requires_payment (gs : GatedSwap) (s : FacilitatorState) (h : gated_swap_valid gs s) :
    gs.auth.utxo ∉ s.spent_utxos := replay_prevented gs.auth s h.1

end X402Cardano.Minswap
