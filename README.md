# Trapstronauts

## Purpose
This is a video game project made for the 2022 Fall semester CSE Game Design Special Topics course at the University of Texas at Arlington.

## Summary
It is a local multiplayer party game, that draws heavy inspirations from another video game called Ultimate Chicken Horse. We borrow the game loop from that title and fit it around a new sci-fi theme. That being 2-4 players vote on a map. Then a proportional voting system chooses at random evenly between each players' vote and then the players then procede to play multiple rounds on it. The players all have the same goal get to the finish line as soon as possible. However, there is a catch, at the beginning of each round the players all place a single item from a small random assortment of items. Some of these items being platforms others being traps. Depending on what the players choose and place it can either make making it to the finish line easier or harder. These traps as well as environmental hazards on the map can kill players and stop them from making it to the finish. At the end of a round, players are awarded points for what they did that round. Once a player earns a certain amount of points they win and the rest of the players lose.

A motif of the game would certainly be that the players are always competeing. Even when they are not racing to the finish. The players will end up fighting over which map to play on. Starting the game before the other players are ready and have voted on a map. Stealing items from other player's when choosing items at the start of every round. Blocking pathways or destroying blocks to the finish line. Making the map harder or easier to navigate against other players' wishes. All these individual design features lead to a very fun experience with a couple of friends to laugh over while playing and after the game is over.

### Points
There is many ways to get points, some events give you more points than others:
- Getting to the finish line, as long as one person perished before making it to the finish line.
- Being the only person to finish.
- From player kills from traps that you placed.
- Post-mortem arrival to the finish line.

### Maps
There is multiple maps included with the demo build.
- Spaceship (Hub)
    - This is where the players start when they load up the game. The player's spawn in separate bedrooms. Here they can vote on a map then go to the portal room and start the game once enough players are in there.
- Sawmill
    - This is a simple but fun map, where there is a sawmill in the center. You can choose the safer option to go over it, if its not blocked or covered in traps from players item placement. You can also go through the sawmill which has two floors in it. Both floors have a two saws with a button in the middle. If a player stands on the button in the middle the saws speed up making it harder to get through the sawmill to the finish line.
- Valley
    - The player's start on the left bank of a steep valley, then the finish line is up above on the right bank. If they fall into the pit between the two banks they die. At first this is unavoidable, so they have to build their way up using platforms and traps.
- Cliffs
    - This is very similair to valley, but a lot smaller. Better for a quick game.
- Canyon
    - The players starts on the left bank of a canyon and the finish is in the bottom right cave in the pit of the canyon. There is two hidden pathes on the outskirts of the map that players can discover and use to get around traps and platforms in the way.

### Voting System
The players vote on which map they want, however, instead of a majority voting, it is proportionally random. Meaning each vote has an equal chance of being randomly selected. For example, if two players voted on Sawmill and one voted on Valley, then it would be a two-thirds chance of being Sawmill and one-thirds chance of being Valley, once the players start the game at the portal room.

### Placement System
At the start of every round on a map, the players get a random assortment of items to choose from, but they have to choose quickly. Once an item has been selected no one else can choose that item. Then the players place The assortment of items is platforms, traps, and bombs. The platforms are for making or blocking pathes to the finish line. Then for traps, most double as a platform, but they all some unique danger associated with them that can kill a player. Finally, there is the bomb which blows up an area of placed items, in the event that the map is impossible or just if a player wants to remove a group of items.

### Future Work
If we were to keep working on the game there is many things we would have liked to add.
- Finish the hub map. It was missing many features from the original vision of the game.
    - A storage bay, containing a mini-game to play while waiting for other players.
    - An engine room, where the host player can tweak settings about the game.
    - Better bedrooms, they were suppose to have beds in them and wardrobes used to customize and choose characters.
- More maps of course.
    - A sun map, where solar flares shoot out and cook anyone hit by one as a unique environmental hazard.
    