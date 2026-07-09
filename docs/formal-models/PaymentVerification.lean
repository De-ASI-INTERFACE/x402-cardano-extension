-- x402-Cardano Payment Verification | Author: Richard Patterson
import X402Cardano.Basic

namespace X402Cardano.Verification

def settle (p : UTXOPayment) (s : LedgerState) (h : verify p s) : LedgerState :=
  { s with spent_utxos := s.spent_utxos ∪ {(p.tx_hash, p.tx_index)} }

theorem settled_utxo_recorded (p : UTXOPayment) (s : LedgerState) (h : verify p s)
    : (p.tx_hash, p.tx_index) ∈ (settle p s h).spent_utxos := by
  simp [settle, Finset.mem_union, Finset.mem_singleton]

end X402Cardano.Verification
