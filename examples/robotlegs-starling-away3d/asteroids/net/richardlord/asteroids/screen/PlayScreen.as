package net.richardlord.asteroids.screen
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.ash.tick.TickProvider;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.events.StartGameEvent;
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
			
			injector.map(GameState).asSingleton();
			injector.map(EntityCreator).asSingleton();
			injector.map(KeyPoll).toValue(new KeyPoll(this.stage));
			injector.map(TickProvider).toValue(new FrameTickProvider(this));
			
			game = injector.getInstance(Game);
			game.addSystem(new GameManager(), SystemPriorities.preUpdate);
			game.addSystem(new MotionControlSystem(), SystemPriorities.update);
			game.addSystem(new GunControlSystem(), SystemPriorities.update);
			game.addSystem(new BulletAgeSystem(), SystemPriorities.update);
			game.addSystem(new MovementSystem(), SystemPriorities.move);
			game.addSystem(new CollisionSystem(), SystemPriorities.resolveCollisions);
			game.addSystem(new RenderSystem(), SystemPriorities.render);
			
			// automatically start game
			start();
		}

		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			// TODO unmap stuff
		}
		
		/**
		 * Starts the game
		 */
		public function start() : void
		{
			trace(DEBUG_TAG, 'start()');
			
			var injector:Injector = context.injector;
			var gameState:GameState = injector.getInstance(GameState);
			
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;
			gameState.width = this.stage.stageWidth;
			gameState.height = this.stage.stageHeight;

			var tickProvider:TickProvider = injector.getInstance(TickProvider);
			tickProvider.add(game.update);
			tickProvider.start();
		}
		

	}

}