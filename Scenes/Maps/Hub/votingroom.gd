extends Node2D

onready var cand = $Candidates

func _ready():
    for c in cand:
        c.update_votes()

func update_votes(players):
    pass
