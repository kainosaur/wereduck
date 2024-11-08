extends Node
class_name StateMachine

#You may drag a state into the "initial state" variable 
#in the inspector to set a defualt state
@export var initial_state : State 


#Track current state and initialize empty "states" dictionary
var current_state : State
var states : Dictionary = {}

#Check for state objects among children nodes, then add them to dictionary 
#with the name of the node as the key and the node itself as the value
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(on_state_transition)
	#Apply initial state
	if initial_state:
		initial_state.enter()
		current_state = initial_state

#Process state's process code every process frame
func _process(delta):
	if current_state:
		current_state.update(delta)
	
#Process state's physics code every physics frame
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)


func on_state_transition(current_state_name, new_state_name):
	#Check if correct state is calling transition
	if current_state_name != current_state:
		return
	#Check for new state name in dictionary 
	var transitioning_to = states.get(new_state_name.to_lower())
	if !transitioning_to:
		print("No transition named %s", new_state_name.to_lower())
		return
	#Check if current state, if true, call exit on current state
	if current_state:
		current_state.exit()
	#Call enter on state we are transitioning to and update current_state tracker
	transitioning_to.enter()
	current_state = transitioning_to
	
	

	
	
	 
