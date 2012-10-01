package net.richardlord.asteroids.screens
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Abiyasa
	 */
	public class DummyStarlingContainer extends Sprite
	{
		protected var _q:Quad;
		
		public function DummyStarlingContainer()
		{
			trace('creating dummy starling container');
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded ( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			trace('dummy starling container added to stage');
			
			_q = new Quad(100, 100);
			_q.setVertexColor(0, 0x000000);
			_q.setVertexColor(1, 0xAA0000);
			_q.setVertexColor(2, 0x00FF00);
			_q.setVertexColor(3, 0x0000FF);
			_q.x = 100;
			_q.y = 100;
			
			addChild(_q);
			
			trace('dummy width=' + this.width + ' height=' + this.height);
		}
		
	}

}