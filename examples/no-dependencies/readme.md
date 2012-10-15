# Ashteroids
Simple Asteroids game example, without Robotlegs and automatic injector

This is my personal experiment extending the Asteroids game example from Richard Lord's [Ash Framework](http://github.com/richardlord/Ash).

The Asteroids example is extended to support 3 rendering modes in one game:

* Flash's Display List (original)
* Starling framework
* Away3D

User will be able to select rendering mode before the game starts.

[TODO attach screen shots]

**Note:** If you're not familiar with Ash Framework or entity-component system, checkout:

* Games and Entity Systems: http://shaun.boyblack.co.za/blog/2012/08/04/games-and-entity-systems/
* "Ash - a new entity framework for Actionscript games.":http://www.richardlord.net/blog/introducing-ash
* "What is an entity framework for game development.":http://www.richardlord.net/blog/what-is-an-entity-framework
* "Why use an entity framework for game development.":http://www.richardlord.net/blog/why-use-an-entity-framework

## Multiple Rendering Modes

Using Ash framework, it is easy to switch between renderers. The game logic and other components stay the same; the only difference is which renderer system is being used.

[TODO attach code]

Currently, the user can only select the rendering mode before the game starts. In theory, it's possible to change the rendering mode in the middle of the game; I just don't have time to do it ;-)

# Status
- adding multi screen manager: **done**
- add Starling support: **done**
- add Away3D support: **done**
- Enchanced graphics with Starling Sprite and animations: **not yet**
- Change game rendering mode during the game: **not yet**
