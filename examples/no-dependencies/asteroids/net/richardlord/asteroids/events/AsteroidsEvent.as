package net.richardlord.asteroids.events
{
	import flash.events.Event;
	
	/**
	 * Event during game play displathed by Asteroids game engine
	 * @author Abiyasa
	 */
	public class AsteroidsEvent extends Event
	{
		public static const GAME_OVER:String = 'gameOver';
		
		public function AsteroidsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event
		{
			return new AsteroidsEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("AsteroidsEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}