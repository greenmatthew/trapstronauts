# Trapstronauts

![Trapstronauts Preview](https://www.matthewgreen.gg/trapstronauts/preview.png)

## Links
- [Matthew's Personal Git Repo](https://git.matthewgreen.gg/matthewgreen/Trapstronauts.git)
- [Github Repo](https://github.com/greenmatthew/Trapstronauts)

## Content
- [Purpose](#purpose)
- [Summary](#summary)
    - Demo Video
- [Points](#points)
- [Maps](#maps)
    - Spaceship (Hub) Screenshot
    - Sawmill Screenshot
    - Valley Screenshot
    - Cliffs Screenshot
    - Canyon Screenshot
- [Voting System](#voting-system)
    - Voting Screenshot
- [Placement System](#placement-system)
    - Placement Screenshots
- [Conclusion](#conclusion)
- [Future Work](#future-work)

## Purpose
This is a video game project made for the 2022 Fall semester CSE Game Design Special Topics course at the University of Texas at Arlington.

## Summary
It is a local multiplayer party game, made in Godot Engine 3, which draws heavy inspirations from another video game called Ultimate Chicken Horse. We borrow the game loop from that title and fit it around a new sci-fi theme. First, 2-4 players vote on a map. Then a proportional voting system chooses at random evenly between each players' vote and then the players then proceed to play multiple rounds on it. The players all have the same goal of getting to the finish line as soon as possible. However, there is a catch, at the beginning of each round the players all choose and place a single item from a random assortment of items. Depending on what they choose it can either make it easier or harder to get to the finish line. The traps as well as environmental hazards on the map can kill players and stop them from making it to the finish. At the end of a round, players are awarded points for what they did that round. Once a player earns a certain number of points they win, and the rest of the players lose.

A motif of the game is that the players are always able to compete and harass other players through different game functionalities, even before they are racing for points. Which makes it the perfect game to play with a group of friends to laugh over.

https://user-images.githubusercontent.com/45467733/223187027-faade077-9cdd-4e8c-ace7-032beaf850d8.mp4

Trapstronauts Demo Video: Due to the way the demo was recorded the audio cuts out frequently in the recording.

## Points
There are many ways to get points, some events give you more points than others:
- Getting to the finish line, as long as one person perished before making it to the finish line.
- Being the only person to finish.
- Being the first person to finish, if not the only person to finish.
- Kills from traps you have placed.
- Post-mortem arrival to the finish line.

![Trapstronauts Points System](https://www.matthewgreen.gg/trapstronauts/points_system.png)

## Maps
There are multiple maps included with the demo build.

![Trapstronauts Spaceship (Hub) Map](https://www.matthewgreen.gg/trapstronauts/map_hub_labelled.png)
This is where the players start when they load up the game. The players spawn in separate bedrooms. Here they can vote on a map then go to the portal room and start the game once enough players are in there.

![Trapstronauts Sawmill Map](https://www.matthewgreen.gg/trapstronauts/map_sawmill_labelled.png)
This is a simple but fun map, where there is a sawmill in the center. You can choose the safer option to go over it if it is not blocked or covered in traps from players’ item placements. You can also go through the sawmill which has two floors in it. Both floors have two saws with a button in the middle. If a player stands on the button in the middle, the saws speed up making it harder to get through the sawmill.

![Trapstronauts Valley Map](https://www.matthewgreen.gg/trapstronauts/map_valley_labelled.png)
The players start on the left bank of a steep valley with the finish line up above on the right bank. If they fall into the pit between the two banks they perish. At first this is unavoidable, so they must build their way up using platforms and traps.

![Trapstronauts Cliffs Map](https://www.matthewgreen.gg/trapstronauts/map_cliffs_labelled.png)
This is very similar to valley, but a lot smaller. It is the best map for a quick game.

![Trapstronauts Canyon Map](https://www.matthewgreen.gg/trapstronauts/map_canyon_labelled.png)
The players start on the left bank of a canyon and the finish is in the bottom right cave inside the canyon. There are two hidden paths on the outskirts of the map that players can discover and use to get around traps and platforms in the way.

## Voting System
The players vote on which map they want, however, instead of a majority vote winning, it is proportionally selected at random. Meaning each vote has an equal chance of being randomly selected. For example, if two players voted on Sawmill and one voted on Valley, then it would be a two-thirds chance of being Sawmill and one-thirds chance of being Valley, once the players start the game at the portal room.

![Trapstronauts Voting System](https://www.matthewgreen.gg/trapstronauts/voting_system.png)

## Placement System
At the start of every round, the players get a random assortment of items, which can be platforms, traps, and bombs, but they must choose quickly and wisely. Once an item has been selected you are locked in and no one else can choose that item. After all the players have chosen an item, then they all at once try and place their items where they’d like to. Then after all items are placed they race to the finish.

The platforms are for making or blocking paths to the finish line. Then for the traps they can kill players making it harder to get to the finish but can also sometimes be used as a platform. Finally, there is the bombs, which blow up a small areas of placed items, which is useful for if the map is impossible or if a player wants to remove a group of items. Most players usually have their own path to get to the finish through the map and they place items to make their path easier or to make others' paths harder to navigate without dying.

![Trapstronauts Placement System 0](https://www.matthewgreen.gg/trapstronauts/placement_system_0.png)
![Trapstronauts Placement System 1](https://www.matthewgreen.gg/trapstronauts/placement_system_1.png)
![Trapstronauts Placement System 2](https://www.matthewgreen.gg/trapstronauts/placement_system_2.png)

## Conclusion
The final demo build was genuinely fun to play with some friends. Although it did have more bugs in it then we would like to admit. Overall, it was a remarkable success. If it had more content it really be a contender for publishing on Steam or other digital game vendors.

## Future Work
If we were to keep working on the game there is many things we would have liked to add.
- Finish the hub map. It was missing many features from the original vision of the game.
    - A storage bay - containing a mini-game to play while waiting for other players.
    - An engine room - where the host player can tweak settings about the game.
    - Better bedrooms - they were supposed to have beds in them, and wardrobes used to customize and choose characters. Also motion sensing doors, that only open to the owner's motion. You could lock a player in your bedroom if you wanted.
- More maps of course.
    - Sun - where solar flares shoot out and cook anyone hit by one as a unique environmental hazard.
    - Mini Moons - where multiple miniature moons are present and have a gravitational pull on the players as they get near, making it difficult to get past them to the finish.
    - Mountainous or City Skyline Planet - where the players are occasionally hit by gusts of wind, which happen at random times with random force and duration.
    - Caverns Planet - where the players are underground in a cavern and there is platforms that crumble a second after they are touched, sending any player or players on top to fall to their deaths. Any crumbled platforms would reappear the following round.
    - Ice Planet - where all the starting surfaces start with ice, causing the players to slide when moving on to it. Occasionally a blizzard will come through making it hard to see. There is a small warning before the blizzard so you at least have a little time to hunker down. During a blizzard there is a chance for the surfaces of player placed items, if not already, to become covered in ice.
    - Stormy Planet - the overall visibility of the map is limited because from an intense thunderstorm occurring. At occasional, random intervals lightning strikes greatly increasing visibility for a short period before fading back to darkness. An additional idea would be where there is a small change that the lightning could strike a player if they do not have a structure above them. Also if the lighting strikes metal, then it will kill any players touching the metal.
- More items to place
    - An alternative bigger bomb, with a larger radius of item removal.
    - Rotator - creates a physical rotation system, which rotates any cardinally adjacent placed items.
    - Alien Goo - a sticky substance that attaches items together into one whole physical structure. It also slows down a player if they are touching it. This can be used to attach more items to a rotator's rotation system.
    - Electrifier - when placed next to metal items, it kills anything touching them, upon a fixed timer going off. The electrical system can be extended by placing metal items adjacent to other metal items.
    - And much more, but these are the most notable.
- Laser Reflections - so when a rotator rotates a laser or a laser drone shoots at the player, any metal items reflect the laser, possibly causing a chain reaction of reflections and possibly killing players.
- Unique characters to choose from and customize like talked about with the hub’s bedroom wardrobes.
- Alternate start and finishes to maps, maybe the player goes from the start to the finish and back to the start. Or maybe the start and finish moved round by round.
- And so much more.
