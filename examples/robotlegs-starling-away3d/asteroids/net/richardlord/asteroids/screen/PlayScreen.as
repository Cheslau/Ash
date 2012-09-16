package net.richardlord.asteroids.screen
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.ash.tick.TickProvider;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.core.api.IContext;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * The game play screen
	 * @author Abiyasa
	 */
	public class PlayScreen extends ScreenBase
	{
		public static const DEBUG_TAG:String = 'PlayScreen';
		
		[Inject]
		// TODO this is still not working!
		public var context:IContext;
		
		[Inject]
		// TODO this is still not working!
		public var game:Game;
		
		/** The game state */
		protected var _gameState:GameState;
		
		// TODO If injection works, remove param theContext
		public function PlayScreen(theContext:IContext = null)
		{
			super();
			
			if (theContext)
			{
				context = theContext;
			}
		}
		
		override protected function init(e:Event):void
		{
			super.init(e);
			
			// init game
			var injector:Injector = context.injector;
			
			_gameState = new GameState();
			injector.map(ScreenBase).toValue(this);
			injector.map(GameState).toValue(_gameState);
			injector.map(EntityCreator).asSingleton();
			injector.map(KeyPoll).toValue(new KeyPoll(this.stage));
			injector.map(TickProvider).toValue(new FrameTickProvider(this));
			
			resetGame();
			startGame();
		}

		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			
			trace(DEBUG_TAG, 'destroy()');
		}
		
		protected function destroyGame():void
		{
			var injector:Injector = context.injector;
			
			stopGame();
			var tickProvider:TickProvider = injector.getInstance(TickProvider);
			tickProvider.remove(playScreenTick);
			tickProvider.remove(game.update);
			
			game = injector.getInstance(Game);
			game.removeAllSystems();
			game.removeAllEntities();
			
			// unmap stuff
			injector.unmap(ScreenBase);
			injector.unmap(GameState);
			injector.unmap(EntityCreator);
			injector.unmap(KeyPoll);
			injector.unmap(TickProvider);
		}
		
		/**
		 * Resets and prepare the game system
		 */
		protected function resetGame():void
		{
			var injector:Injector = context.injector;
			game = injector.getInstance(Game);
			
			// empty first
			game.removeAllEntities();
			game.removeAllSystems();
			
			// init systems
			game.addSystem(new GameManager(), SystemPriorities.preUpdate);
			game.addSystem(new MotionControlSystem(), SystemPriorities.update);
			game.addSystem(new GunControlSystem(), SystemPriorities.update);
			game.addSystem(new BulletAgeSystem(), SystemPriorities.update);
			game.addSystem(new MovementSystem(), SystemPriorities.move);
			game.addSystem(new CollisionSystem(), SystemPriorities.resolveCollisions);
			game.addSystem(new RenderSystem(), SystemPriorities.render);
			
			// init ticker
			var tickProvider:TickProvider = injector.getInstance(TickProvider);
			tickProvider.add(playScreenTick);
			tickProvider.add(game.update);
			tickProvider.start();
		}
		
		/**
		 * Starts the game
		 */
		protected function startGame():void
		{
			trace(DEBUG_TAG, 'start()');
			
			var injector:Injector = context.injector;
			
			// reset game state
			_gameState.level = 0;
			_gameState.lives = 1;
			_gameState.points = 0;
			_gameState.width = this.stage.stageWidth;
			_gameState.height = this.stage.stageHeight;
			_gameState.status = GameState.STATUS_PLAY;

			var tickProvider:TickProvider = injector.getInstance(TickProvider);
			tickProvider.start();
		}
		
		/**
		 * Stops the game loop
		 */
		protected function stopGame():void
		{
			var injector:Injector = context.injector;
			var tickProvider:TickProvider = injector.getInstance(TickProvider);
			tickProvider.stop();
		}
		
		/**
		 * For controlling frame loop
		 * @param	time
		 */
		public function playScreenTick(time:Number):void
		{
			switch (_gameState.status)
			{
			case GameState.STATUS_GAME_OVER:
				// trigger remove to go back to main menu
				// TODO properr destroy
				destroyGame();
				context.dispatcher.dispatchEvent(new ShowScreenEvent(ShowScreenEvent.SHOW_SCREEN, 'startMenu'));
				break;
			}
		}
	}

}