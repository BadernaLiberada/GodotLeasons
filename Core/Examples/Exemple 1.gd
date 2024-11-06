class_name Exemple1
extends Node										# Extender é usado para pegar os codigos dessa classe.

#region
@export_category("Entity Stats")

var _health : float = 10.0 							# Declarar tipo deixa o jogo mais rapido!
var _mana := 10.0									# Assim tambem funciona.
@export_range(0.0,10.0) var _maxStamina := 5.0		# Util pra editar rapido na cena
@export_enum("Danilo", "Thais", "Karma") var character_name: String
@export_category("Extras")
@export_color_no_alpha var _color : Color
#endregion

func _OiYinTudoBem() -> void:						# Definir retorno deixa seu jogo mais rapido!
	print("Tudo sim 👍👍")

func _init() -> void:								# Roda antes de tudo, incluindo antes das variaveis serem setadas
	pass

func _ready() -> void: 								# Roda no primeiro frame do jogo.
	pass 											# Replace with function body.

func _process(delta: float) -> void:				# Roda todo frame.
	pass

func _physics_process(delta: float) -> void:		# Roda a cada frame de fisica (movimento e quase tudo é aqui)
	pass

func _unhandled_input(event: InputEvent) -> void:	# Util pra pegar input especifico mas não precisa ser aqui
	pass
