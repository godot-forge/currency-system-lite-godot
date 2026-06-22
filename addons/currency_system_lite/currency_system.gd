extends Node

const MAX_CURRENCIES := 3

signal balance_changed(currency_id: String, old_balance: float, new_balance: float)
signal insufficient_funds(currency_id: String, required: float, available: float)

var _wallets: Dictionary = {}

func define(currency_id: String, display_name: String, initial: float = 0.0) -> void:
	if _wallets.size() >= MAX_CURRENCIES and not _wallets.has(currency_id):
		push_warning("Currency Lite: max %d currencies reached." % MAX_CURRENCIES)
		return
	_wallets[currency_id] = {"name": display_name, "balance": maxf(0.0, initial)}

func has_currency(currency_id: String) -> bool:
	return _wallets.has(currency_id)

func balance(currency_id: String) -> float:
	return _wallets.get(currency_id, {}).get("balance", 0.0)

func display_name(currency_id: String) -> String:
	return _wallets.get(currency_id, {}).get("name", "")

func earn(currency_id: String, amount: float) -> void:
	if not _wallets.has(currency_id) or amount <= 0.0:
		return
	var old: float = _wallets[currency_id]["balance"]
	_wallets[currency_id]["balance"] += amount
	emit_signal("balance_changed", currency_id, old, _wallets[currency_id]["balance"])

func spend(currency_id: String, amount: float) -> bool:
	if not _wallets.has(currency_id) or amount <= 0.0:
		return false
	var bal: float = _wallets[currency_id]["balance"]
	if bal < amount:
		emit_signal("insufficient_funds", currency_id, amount, bal)
		return false
	var old: float = bal
	_wallets[currency_id]["balance"] -= amount
	emit_signal("balance_changed", currency_id, old, _wallets[currency_id]["balance"])
	return true

func can_afford(currency_id: String, amount: float) -> bool:
	return balance(currency_id) >= amount

func set_balance(currency_id: String, amount: float) -> void:
	if not _wallets.has(currency_id):
		return
	var old: float = _wallets[currency_id]["balance"]
	_wallets[currency_id]["balance"] = maxf(0.0, amount)
	emit_signal("balance_changed", currency_id, old, _wallets[currency_id]["balance"])

func currency_ids() -> Array:
	return _wallets.keys()

func save_state() -> Dictionary:
	var data: Dictionary = {}
	for id in _wallets:
		data[id] = _wallets[id]["balance"]
	return data

func load_state(data: Dictionary) -> void:
	for id in data:
		if _wallets.has(id):
			_wallets[id]["balance"] = maxf(0.0, data[id])
