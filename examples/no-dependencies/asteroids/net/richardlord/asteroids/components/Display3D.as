package net.richardlord.asteroids.components
{
	import away3d.containers.ObjectContainer3D;
	
	public class Display3D
	{
		public var object3D:ObjectContainer3D = null;
		
		public function Display3D(object3D:ObjectContainer3D)
		{
			this.object3D = object3D;
		}
	}
}
