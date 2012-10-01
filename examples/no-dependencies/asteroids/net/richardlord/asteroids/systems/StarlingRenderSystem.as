package net.richardlord.asteroids.systems
{
	import flash.display.Stage;
	import net.richardlord.ash.core.System;
	import starling.core.Starling;
	
	/**
	 * Render system using Starling Framework
	 * @author Abiyasa
	 */
	public class StarlingRenderSystem extends System
	{
		public var stage:Stage;
		
		protected var _starling:Starling;
		
		public function StarlingRenderSystem(stage:Stage)
		{
			stage = stage;
			
		}
		
	}

}