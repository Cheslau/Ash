package net.richardlord.asteroids.screens
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Abiyasa
	 */
	public class DummyStarlingContainer extends Sprite
	{
		
		public function DummyStarlingContainer()
		{
			trace('creating dummy starling container');
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded ( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			trace('dummy starling container added to stage');
			trace('dummy width=' + this.width + ' height=' + this.height);
		}
		
		private function onRemoved(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);

			trace('dummy starling container removed from stage');
			
			this.removeChildren();
		}
		
	}

}