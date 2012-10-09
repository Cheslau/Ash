package net.richardlord.asteroids.nodes
{
	import net.richardlord.ash.core.Node;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.Display3D;
	
	/**
	 * Rendering node for Away3D 3D object
	 * @author Abiyasa
	 */
	public class Away3DRenderNode extends Node
	{
		public var position:Position;
		public var display3D:Display3D;
	}
}
