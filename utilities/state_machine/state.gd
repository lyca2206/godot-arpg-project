extends Node
class_name State

var entity: StateMachine

func setup(_entity):
	entity = _entity

func input(_event: InputEvent):
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func enter():
	entity.send_debug_message("Entered " + str(self.name) + ".")

func exit():
	entity.send_debug_message("Exited " + str(self.name) + ".")
