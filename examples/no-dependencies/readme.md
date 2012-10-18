# Ashteroids
Simple Asteroids game example, without Robotlegs and automatic injector

This is my personal experiment extending the Asteroids game example from Richard Lord's [Ash Framework](http://github.com/richardlord/Ash).

The Asteroids example is extended to support 3 rendering modes in one game:

* Flash's Display List (original)
* Starling framework
* Away3D

User will be able to select rendering mode before the game starts.

## Screenshots
User will be able to select rendering mode before the game starts.

![Mode selection](http://abiyasa.com/lab/away3d/ashteroids/main_menu.png "Mode selection")

Flash Display List mode

![Flash Display List](http://abiyasa.com/lab/away3d/ashteroids/mode_native.png "Flash Display List")
Starling framework mode

![Starling mode](http://abiyasa.com/lab/away3d/ashteroids/mode_starling.png "Starling framework")
Away3D 4 mode

![Away3D 4 mode](http://abiyasa.com/lab/away3d/ashteroids/mode_away3d.png "Away3D 4")

## Demo
For online demo: http://abiyasa.com/lab/away3d/ashteroids/

## Multiple Rendering Modes

**Note:** If you're not familiar with Ash Framework or entity-component system, checkout:

* Games and Entity Systems: http://shaun.boyblack.co.za/blog/2012/08/04/games-and-entity-systems/
* "Ash - a new entity framework for Actionscript games.":http://www.richardlord.net/blog/introducing-ash
* "What is an entity framework for game development.":http://www.richardlord.net/blog/what-is-an-entity-framework
* "Why use an entity framework for game development.":http://www.richardlord.net/blog/why-use-an-entity-framework

Using Ash framework, it is easy to switch between renderers. The game logic and other components stay the same; the only difference is which renderer system is being used. See the following code (simplified):
```actionscript
game = new Game();
creator = new EntityCreator(config, game);
keyPoll = new KeyPoll(container.stage);

// add generic systems
game.addSystem(new GameManager(creator, config), SystemPriorities.preUpdate);
game.addSystem(new MotionControlSystem(keyPoll), SystemPriorities.update);
game.addSystem(new GunControlSystem(keyPoll, creator), SystemPriorities.update);
game.addSystem(new BulletAgeSystem(creator), SystemPriorities.update);
game.addSystem(new MovementSystem(config), SystemPriorities.move);
game.addSystem(new CollisionSystem(creator), SystemPriorities.resolveCollisions);
game.addSystem(new GameStateControlSystem(keyPoll), SystemPriorities.update);

// handle rendering system
switch (config.renderMode)
{
case GameConfig.RENDER_MODE_STARLING:
    ... // init stage3d and context here ...
    game.addSystem(new StarlingRenderSystem(container.stage, _stage3DProxy), SystemPriorities.render);
    break;
    
case GameConfig.RENDER_MODE_AWAY3D:
    ... // init stage3d and context here ...
    game.addSystem(new Away3DRenderSystem(container, _stage3DProxy), SystemPriorities.render);
    break;
    
case GameConfig.RENDER_MODE_DISPLAY_LIST:
default:
    game.addSystem(new RenderSystem(container), SystemPriorities.render);
    break;
}
```

From the code above, we add different render system to the game based on the selected rendering mode. The other systems (movement, control, collision detection, .., bullet system) stay the same, unless you want it behave differently based on the rendering mode. Nice, isn't it?

For full code, please check:
* https://github.com/abiyasa/Ash/blob/master/examples/no-dependencies/asteroids/net/richardlord/asteroids/Asteroids.as
* https://github.com/abiyasa/Ash/blob/master/examples/no-dependencies/asteroids/net/richardlord/asteroids/EntityCreator.as

Currently, the user can only select the rendering mode before the game starts. In theory, it's possible to change the rendering mode in the middle of the game; I just don't have time to do it ;-)

# Status
- adding multi screen manager: **done**
- add Starling support: **done**
- add Away3D support: **done**
- Enchanced graphics with Starling Sprite and animations: **not yet**
- Change game rendering mode during the game: **not yet**
