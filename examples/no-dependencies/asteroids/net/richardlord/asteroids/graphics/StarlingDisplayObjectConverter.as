package net.richardlord.asteroids.graphics
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * A simple converter from Flash native display object into Starling Image
	 * @author Abiyasa
	 */
	public class StarlingDisplayObjectConverter extends Image
	{
		protected var _displayObject:DisplayObject;
		
		public function StarlingDisplayObjectConverter(nativeObject:DisplayObject)
		{
			_displayObject = nativeObject;
			var textureBitmap:BitmapData = StarlingDisplayObjectConverter.convertDisplayObjectToBitmap(nativeObject);
			
			super(Texture.fromBitmapData(textureBitmap));
			
			this.readjustSize();
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
		}
		
		/**
		 * Code Borrowed from Richard Lord's FruitFly BitmapCreator
		 * @see https://github.com/richardlord/Fruitfly/blob/master/src/net/richardlord/fruitfly/BitmapCreator.as
		 *
		 * @param	displayObject
		 * @param	scale
		 * @param	quality
		 * @return a bitmap data
		 */
		public static function convertDisplayObjectToBitmap(displayObject:DisplayObject, scale:Number = 1, quality:String = StageQuality.BEST):BitmapData
		{
			var bounds:Rectangle = displayObject.getBounds(displayObject);
			
			var w:int = Math.abs(Math.ceil(bounds.width * scale));
			var h:int = Math.abs(Math.ceil(bounds.height * scale));
			var bitmapData:BitmapData = new BitmapData(w, h, true, 0);
			var absScale:Number = (scale < 0) ? -scale : scale;
			var x:Number = -bounds.left * absScale;
			var y:Number = -bounds.top * absScale;
			
			var transform:Matrix = new Matrix();
			transform.a = scale;
			transform.d = scale;
			transform.tx = x;
			transform.ty = y;
			bitmapData.drawWithQuality(displayObject, transform, null, null, null, true, quality);
			
			return bitmapData;
		}
	}
}