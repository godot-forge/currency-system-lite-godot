@tool
extends EditorPlugin

func _enable_plugin() -> void:
	add_autoload_singleton("Currency", "res://addons/currency_system_lite/currency_system.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("Currency")
