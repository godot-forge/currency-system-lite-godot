# Currency System Lite — Godot 4

Free Godot 4 addon for multi-currency wallets — earn, spend, balance, save/load.

## Features (Lite — Free, max 3 currencies)

- `define(id, name, initial)` — register a currency
- `earn(id, amount)` / `spend(id, amount)` → returns bool
- `balance(id)` / `can_afford(id, amount)`
- `set_balance(id, amount)`
- `save_state()` / `load_state()`
- Signals: `balance_changed(id, old, new)` / `insufficient_funds(id, required, available)`

## Quick Start

```gdscript
# Autoload: Currency
Currency.define("gold", "Gold", 100.0)
Currency.earn("gold", 50.0)
if Currency.spend("gold", 30.0):
    print("Bought item!")
```

## Upgrade to PRO

[Currency System PRO](https://godot-forge.itch.io/currency-system-pro-godot) adds:
- Unlimited currencies
- Exchange rates + `exchange(from, to, amount)`
- Min/Max balance caps
- Transaction history log
- `transaction_recorded` signal

---
Made with ♥ by [GodotForge](https://itch.io/profile/godot-forge)
