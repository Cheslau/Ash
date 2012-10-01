package net.richardlord.asteroids.nodes
{
	import net.richardlord.ash.core.Node;
	import net.richardlord.asteroids.components.StarlingDisplay;
	import net.richardlord.asteroids.components.Position;
	
	/**
	 * Rendering node for starling based display object
	 * @author Abiyasa
	 */
	public class StarlingRenderNode extends Node
	{
		public var position:Position;
		public var starlingDisplay:StarlingDisplay;
	}

}
