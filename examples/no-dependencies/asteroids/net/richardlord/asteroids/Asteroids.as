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
	import net.richardlord.asteroids.systems.StarlingRenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;
	import net.richardlord.asteroids.screens.DummyStarlingContainer;
	import starling.events.Event;
	
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
		
		protected var _starling:Starling;

		
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
				
				gameState.renderMode = GameState.RENDER_MODE_STARLING;
				
				// init starling
				// Note: still have problems when init for the 2nd time (blank screen)
				Starling.multitouchEnabled = false;
				Starling.handleLostContext = true;
				_starling = new Starling(DummyStarlingContainer, container.stage);
				_starling.simulateMultitouch = false;
				_starling.enableErrorChecking = true;
				_starling.addEventListener(Event.CONTEXT3D_CREATE, onStarlingContextCreated);
				_starling.addEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
				break;
				
			case MODE_DISPLAY_LIST:
			default:
				gameState.renderMode = GameState.RENDER_MODE_DISPLAY_LIST;
				
				trace('init game for DisplayList');
				game.addSystem(new RenderSystem(container), SystemPriorities.render);
				break;
			}
		}
		
		/**
		 * Handle Starling context created
		 * @param	event
		 */
		private function onStarlingContextCreated(event:Event):void
		{
			_starling.removeEventListener(Event.CONTEXT3D_CREATE, onStarlingContextCreated);
			
			// Drop down to 30 FPS for software render mode
			const driverInfo:String = _starling.context.driverInfo.toLowerCase();
			if (driverInfo.indexOf("software") != -1)
			{
				_starling.nativeStage.frameRate = 30;
				
				trace('dropping framerate to 30');
			}

			trace('context created for Starling:', driverInfo);
		}
		
		/**
		 *
		 * @param	event
		 */
		private function onStarlingRootCreated(event:Event):void
		{
			_starling.removeEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
			
			trace('Starling root is ready!');
			
			// Starling is ready for rendering
			game.addSystem(new StarlingRenderSystem(_starling), SystemPriorities.render);
		}
		
		private function destroy():void
		{
			game.removeAllEntities();
			game.removeAllSystems();
			
			switch (_mode)
			{
			case MODE_STARLING:
				// TODO how to destroy starling properly?
				_starling.dispose();
				_starling = null;
				break;
			}
			
		}
		
		public function start():void
		{
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;
			gameState.status = GameState.STATUS_PLAY;

			switch (_mode)
			{
			case MODE_STARLING:
				_starling.start();
				break;
			}
			
			tickProvider.add(game.update);
			tickProvider.add(playScreenTick);
			tickProvider.start();
		}
		
		public function stop():void
		{
			tickProvider.stop();
			tickProvider.removeAll();
			
			switch (_mode)
			{
			case MODE_STARLING:
				_starling.stop();
				break;
			}
			
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
