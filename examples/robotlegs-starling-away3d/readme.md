# Asteroids with Robotlegs and Starlings
Simple game example with Robotlegs and automatic injector

My plan is to extend the original example with Starling.

# Status
So far, I have problem with the injection. The RenderSystem by default
has its container injected as DisplayObjectContainer. I tried to change 
it to ScreenBase but it doesn't fix the problem. 

The PlayScreen somehow generated twice (if you replay the game) and 
the RenderSystem gets the wrong PlayScreen. This will cause problem
when trying to remove element form the displayObject


- ~~adding multi screen manager: wip~~
- ~~replace Flash DisplayList/Object with Starling: wip~~
- ~~Enchanced graphics with Sprite and animations: wip~~
