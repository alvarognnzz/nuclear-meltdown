extends CSGBox3D

var interaction = {
	"key": "E",
	"input": "interact",
	"name": "Interact",
}

func can_interact():
	return true

func interact():
	print('interact')
