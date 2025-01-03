extends Node

# interaction
signal change_interaction_progress(value)
signal object_being_moved(value: bool)

# elevator_door
signal toggle_elevator_door

# resolution
signal resolution_changed(width, height)

# jumpable
signal landed_on_jumpable(jumpable)

# using_computer
signal using_computer(value, global_position)
