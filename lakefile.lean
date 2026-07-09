import Lake
open Lake DSL
package «x402-cardano» where
  name := "x402-cardano"
require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"
lean_lib «X402Cardano» where
  roots := #[`X402Cardano]
