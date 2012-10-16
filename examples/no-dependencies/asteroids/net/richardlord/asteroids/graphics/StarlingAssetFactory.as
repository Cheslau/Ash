package net.richardlord.asteroids.graphics
{
	/**
	 * Factory for creating Starling assets
	 *
	 * @author Abiyasa
	 */
	public class StarlingAssetFactory
	{
		import flash.display.Bitmap;
		import flash.geom.Rectangle;
		import net.richardlord.asteroids.components.StarlingDisplay;
		import net.richardlord.asteroids.graphics.StarlingDisplayObjectConverter;
		import starling.display.Image;
		import starling.textures.SubTexture;
		import starling.textures.Texture;
		
		import net.richardlord.asteroids.graphics.AsteroidView;
		import net.richardlord.asteroids.graphics.BulletView;
		import net.richardlord.asteroids.graphics.SpaceshipView;
		
		[Embed(source="../../../../../assets/ashteroids.png")]
		private static const SpriteSheet:Class;
		
		private var _spriteSheet:Texture;

		// flag to use Bitmap sprite or use vector-generated sprite
		private var _useSprite:Boolean;
		
		public function StarlingAssetFactory(useSprite:Boolean)
		{
			_useSprite = useSprite;
			
			// create texture atlas
			if (_useSprite)
			{
				var bitmap:Bitmap = new SpriteSheet();
				_spriteSheet = Texture.fromBitmap(bitmap);
			}
		}
		
		public function createAsteroid(radius:Number):StarlingDisplay
		{
			var tempResult:StarlingDisplay;
			if (_useSprite)
			{
				// TODO handle radius
				tempResult = new StarlingDisplay(createStarlingImageFromTexture(new Rectangle(47, 32, 69, 75)));
			}
			else
			{
				tempResult = new StarlingDisplay(new StarlingDisplayObjectConverter(new AsteroidView(radius)));
			}
			
			return tempResult;
		}
		
		public function createSpaceship():StarlingDisplay
		{
			var tempResult:StarlingDisplay;
			if (_useSprite)
			{
				tempResult = new StarlingDisplay(createStarlingImageFromTexture(new Rectangle(36, 6, 27, 21)));
			}
			else
			{
				tempResult = new StarlingDisplay(new StarlingDisplayObjectConverter(new SpaceshipView()));
			}

			return tempResult;
		}
		
		public function createUserBullet():StarlingDisplay
		{
			var tempResult:StarlingDisplay;
			if (_useSprite)
			{
				tempResult = new StarlingDisplay(createStarlingImageFromTexture(new Rectangle(9, 7, 11, 4)));
			}
			else
			{
				tempResult = new StarlingDisplay(StarlingDisplayObjectConverter(new BulletView()));
			}
			
			return tempResult;
		}
		
		protected function createStarlingImageFromTexture(region:Rectangle):Image
		{
			var subTexture:SubTexture = new SubTexture(_spriteSheet, region);
			var image:Image = new Image(subTexture);
			image.readjustSize();
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
			return image;
		}
	}

}