import Lake
open Lake DSL

package «x402-cardano» where
  version := v!"0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"

lean_lib «X402Cardano» where
  roots := #[`X402Cardano]
