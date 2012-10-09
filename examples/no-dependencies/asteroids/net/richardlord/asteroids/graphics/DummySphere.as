package net.richardlord.asteroids.graphics
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.primitives.WireframeSphere;
	
	/**
	 * Dummy sphere
	 * @author Abiyasa
	 */
	public class DummySphere extends ObjectContainer3D
	{
		
		public function DummySphere(size:int = 0, color:uint = 0xFFFFFF)
		{
			super();
			
			// default size
			if (size <= 0)
			{
				size = 10;
			}
			
			var sphere:Mesh = new Mesh(new WireframeSphere(size, 16, 12, 0xFFFFFFFF));
			this.addChild(sphere);
		}
		
	}

}