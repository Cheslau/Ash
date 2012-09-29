package net.richardlord.asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.events.AsteroidsEvent;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GameStateControlSystem;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;
	
	import starling.core.Starling;


	public class Asteroids
	{
		// main container (DisplayList) for MODE_DISPLAY_LIST
		private var container:DisplayObjectContainer;
		
		// Stage for MODE_STARLING
		private var _stage:Stage;
		
		// the current game rendering mode (starling, Flash DisplayList)
		private var _mode:int;
		public static const MODE_DISPLAY_LIST:int = 0;
		public static const MODE_STARLING:int = 1;
		public static const MODE_AWAY3D:int = 2;
		
		private var game:Game;
		private var tickProvider:FrameTickProvider;
		private var gameState:GameState;
		private var creator:EntityCreator;
		private var keyPoll:KeyPoll;
		private var width:Number;
		private var height:Number;
		
		public function Asteroids(container:DisplayObjectContainer, width:Number, height:Number)
		{
			this.container = container;
			this.width = width;
			this.height = height;
		}
		
		/**
		 * Inits the game
		 * @param	mode The rendering mode
		 */
		public function init(mode:int):void
		{
			this._mode = mode;
			prepare();
		}
		
		/**
		 * Prepares the game and systems
		 */
		private function prepare():void
		{
			game = new Game();
			gameState = new GameState(width, height);
			creator = new EntityCreator(gameState, game);
			keyPoll = new KeyPoll(container.stage);
			
			// add generic systems
			game.addSystem(new GameManager(gameState, creator), SystemPriorities.preUpdate);
			game.addSystem(new MotionControlSystem(keyPoll), SystemPriorities.update);
			game.addSystem(new GunControlSystem(keyPoll, creator), SystemPriorities.update);
			game.addSystem(new BulletAgeSystem(creator), SystemPriorities.update);
			game.addSystem(new MovementSystem(gameState), SystemPriorities.move);
			game.addSystem(new CollisionSystem(creator), SystemPriorities.resolveCollisions);
			game.addSystem(new GameStateControlSystem(gameState, keyPoll), SystemPriorities.update);
			
			tickProvider = new FrameTickProvider(container);
			
			// handle rendering system
			switch (_mode)
			{
			case MODE_STARLING:
				trace('init game for Starling');
				
				// TODO init starling engine
				Starling.multitouchEnabled = false;
				
				// TODO create render system
				break;
				
			case MODE_DISPLAY_LIST:
			default:
				trace('init game for DisplayList');
				game.addSystem(new RenderSystem(container), SystemPriorities.render);
				break;
			}
		}
		
		private function destroy():void
		{
			game.removeAllEntities();
			game.removeAllSystems();
		}
		
		public function start():void
		{
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;
			gameState.status = GameState.STATUS_PLAY;

			tickProvider.add(game.update);
			tickProvider.add(playScreenTick);
			tickProvider.start();
		}
		
		public function stop():void
		{
			tickProvider.stop();
			tickProvider.removeAll();
			
			destroy();
		}
	
		/**
		 * For controlling frame loop
		 * @param	time
		 */
		public function playScreenTick(time:Number):void
		{
			switch (gameState.status)
			{
			case GameState.STATUS_GAME_OVER:
				tickProvider.stop();
				
				container.dispatchEvent(new AsteroidsEvent(AsteroidsEvent.GAME_OVER));
				break;
			}
		}
	}
}
