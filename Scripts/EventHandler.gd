extends Node

# Signals to all subscribers that another tick has passed.
signal timer
## Two parameters: player, placeable
signal player_killed

var _timer_time : float = 0.0 # Time passed in seconds
const timer_interval : float = 3.0 # Interval between timer_ticks in seconds
var timer_ticks : int = 0 # Number of timer_ticks

func _process(delta):
    _timer_time += delta
    if int(floor(_timer_time / timer_interval)) != timer_ticks:
        timer_ticks += 1
        emit_signal("timer")
        # print("Timer signal emitted at tick " + str(timer_ticks) + " at _timer_time " + str(_timer_time))
