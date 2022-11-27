extends Node

# Signals to all subscribers that another tick has passed.
signal timer

# warning-ignore:unused_signal
signal player_killed(player, source)

# warning-ignore:unused_signal
## One parameter: player
signal player_reached_finish(player)

# warning-ignore:unused_signal
signal scene_changed(scene_from, scene_to)

# warning-ignore:unused_signal
## Two parameters: player, cursor_pos
signal player_select_input(player, cursor_pos)

# warning-ignore:unused_signal
## Three parameter: player, placeable, cursor_pos
signal player_try_place(player, placeable, cursor_pos)

var _timer_time : float = 0.0 # Time passed in seconds
const timer_interval : float = 5.0 # Interval between timer_ticks in seconds
var timer_ticks : int = 0 # Number of timer_ticks

func _process(delta):
    _timer_time += delta
    if int(floor(_timer_time / timer_interval)) != timer_ticks:
        timer_ticks += 1
        emit_signal("timer")
