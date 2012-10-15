package net.richardlord.asteroids
{
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import net.richardlord.signals.SignalBase;
	import starling.core.Starling;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.tick.TickProvider;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.ash.integration.starling.StarlingFrameTickProvider;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.events.AsteroidsEvent;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.systems.Away3DRenderSystem;
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
	import flash.utils.setTimeout;
	

	public class Asteroids
	{
		// main container (DisplayList)
		private var container:DisplayObjectContainer;
		
		// Stage for MODE_STARLING
		private var _stage:Stage;
		
		private var _stage3dManager:Stage3DManager;
		private var _stage3DProxy:Stage3DProxy;
		
		private var game:Game;
		private var tickProvider:TickProvider;
		private var creator:EntityCreator;
		private var keyPoll:KeyPoll;
		private var config : GameConfig;
		private var gameState:GameState;
		
		
		public function Asteroids(container:DisplayObjectContainer)
		{
			this.container = container;
		}
		
		/**
		 * Inits the game
		 *
		 * @param	mode The rendering mode. See GameConfig
		 * @param	width screen width
		 * @param	height screen height
		 */
		public function init(renderMode:int, width:int, height:int):void
		{
			config = new GameConfig();
			config.width = width;
			config.height = height;
			config.renderMode = renderMode;

			prepare();
		}
		
		/**
		 * Prepares the game and systems
		 */
		private function prepare():void
		{
			_stage = container.stage;
			if (_stage == null)
			{
				throw new Error('Cannot access Stage');
				return;
			}
			
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
				trace('init game for Starling');
				
				config.renderMode = GameConfig.RENDER_MODE_STARLING;
				
				initContext();
				break;
				
			case GameConfig.RENDER_MODE_AWAY3D:
				trace('init game for Away3D');
				
				config.renderMode = GameConfig.RENDER_MODE_AWAY3D;
				
				initContext();
				break;
				
			case GameConfig.RENDER_MODE_DISPLAY_LIST:
			default:
				trace('init game for DisplayList');
				
				config.renderMode = GameConfig.RENDER_MODE_DISPLAY_LIST;
				
				game.addSystem(new RenderSystem(container), SystemPriorities.render);
				
				notifyReadyToPlay();
				break;
			}
		}

		/**
		 * Init stage3D context
		 */
		protected function initContext():void
		{
			// Define a new Stage3DManager for the Stage3D objects
			_stage3dManager = Stage3DManager.getInstance(_stage);
			
			trace('init context for stage, stageWidth=' + _stage.stageWidth,
				'stageHeight=' + _stage.stageHeight);
		
			// Create a new Stage3D proxy to contain the separate views
			_stage3DProxy = _stage3dManager.getFreeStage3DProxy();
			_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
			_stage3DProxy.antiAlias = 8;
			_stage3DProxy.color = 0x009EEF;
		}
		
		/**
		 * Context is done
		 * @param	event
		 */
		protected function onContextCreated(event:Stage3DEvent):void
		{
			// Drop down to 30 FPS for software render mode
			var driverInfo:String = _stage3DProxy.context3D.driverInfo.toLowerCase();
			if (driverInfo.indexOf("software") != -1)
			{
				container.stage.frameRate = 30;
				
				trace('dropping framerate to 30');
			}
			trace('context created:', driverInfo);

			switch (config.renderMode)
			{
			case GameConfig.RENDER_MODE_AWAY3D:
				game.addSystem(new Away3DRenderSystem(container, _stage3DProxy), SystemPriorities.render);
			
				// ready to play
				notifyReadyToPlay();
				break;
			
			case GameConfig.RENDER_MODE_STARLING:
				game.addSystem(new StarlingRenderSystem(container.stage, _stage3DProxy), SystemPriorities.render);
				
				// TODO wait until starling root is ready before start playing
				setTimeout(notifyReadyToPlay, 1000);
				break;
			}
		}
		
		private function destroy():void
		{
			game.removeAllEntities();
			game.removeAllSystems();
			
			switch (config.renderMode)
			{
			case GameConfig.RENDER_MODE_AWAY3D:
				_stage3DProxy.clear();
				
				_stage3DProxy.removeEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
				_stage3DProxy.dispose();
				_stage3DProxy = null;
				break;
				
			case GameConfig.RENDER_MODE_STARLING:
				_stage3DProxy.clear();
				
				_stage3DProxy.removeEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
				_stage3DProxy.dispose();
				_stage3DProxy = null;
				break;
			}
		}
		
		/**
		 * Init process is done, ready to play
		 */
		protected function notifyReadyToPlay(event:Object = null):void
		{
			trace('notifyReadyToPlay');
			
			var gameStateEntity:Entity = creator.createGame();
			
			// get the active game state
			gameState = gameStateEntity.get(GameState) as GameState;
			
			container.dispatchEvent(new AsteroidsEvent(AsteroidsEvent.READY_TO_PLAY));
		}
		
		public function start():void
		{
			switch (config.renderMode)
			{
			case GameConfig.RENDER_MODE_STARLING:
				tickProvider = new StarlingFrameTickProvider(Starling.current.juggler);
				break;
				
			default:
				tickProvider = new FrameTickProvider(container);
				break;
			}
			
			tickProvider.add(game.update);
			tickProvider.add(playScreenTick);
			tickProvider.start();
		}
		
		public function stop():void
		{
			tickProvider.stop();
			(tickProvider as SignalBase).removeAll();

			destroy();
		}
	
		/**
		 * For controlling frame loop
		 * @param	time
		 */
		public function playScreenTick(time:Number):void
		{
			// TODO Is there any better way to notify game over?
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
