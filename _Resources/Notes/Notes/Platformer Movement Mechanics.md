# Platformer Movement Mechanics
## Walking/Running:
- High Acceleration
- High Deacceleration
- Medium/High Max Speed for Walking/Running respectively
- Turn speed high but no instant
## Jumping:
- Allow braking and changing direction mid-air
- Long duration jumping
- High Jump Height
- Going up takes slightly longer than it does to go down the same height
- Jump is variable height with it continuing to go up a little while after you let go of the jump key
- Allow wall jumping.
## Assists:
- Short coyote time (extra time after no longer being ground to still be able to jump): 0.1s
- Short jump buffer (buffers jump action for a small duration so if the player jumps right before landing they still jump, capturing their intention not their exact input): 0.1s
- Terminal velocity on falling so far falls do not make the player uncontrollable midair.
- Rounded rectangle for the player collider, makes it easier to get up the corner of square edges.
## Fun:
- Walking/Running particles at feet that trail behind the player
- Jump particles at being of jump
- Landing particles at end of jump
- Lean the player slightly towards the direction they are walking and lean even more for when they are running
- Sound effects upon jumping
- Sound effects upon landing