package rbs 
{
	import com.gaiaframework.api.Gaia;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	
	public class LensPowerPic extends MovieClip 
	{
		public var colorMap_mc:MovieClip;
		public var lens_mc:MovieClip;
		public var image:MovieClip;
		
		private var dPoint:Point;
		private var dMap:BitmapData;
		private var dFilter:DisplacementMapFilter;
		
		public function LensPowerPic() 
		{
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			
			TweenMax.to(lens_mc, 0, { transformAroundCenter:{scale:.9}, autoAlpha:0 } );
			
			image.addEventListener(MouseEvent.ROLL_OVER, onPicOver, false, 0, true);
			image.addEventListener(MouseEvent.ROLL_OUT, onPicOut, false, 0, true);
			
			colorMap_mc.mouseEnabled = false;
			colorMap_mc.mouseChildren = false;
			
			Gaia.api.getDepthContainer(Gaia.TOP).addChild(lens_mc); // Put this object in the top, causes x,y changes
			lens_mc.mouseEnabled = false;
			lens_mc.mouseChildren = false;
			
			removeChild(colorMap_mc);
			
			dPoint = new Point(0, 0);
			dMap = new BitmapData(colorMap_mc.width, colorMap_mc.height, true, 0x808080)
			
			dMap.draw(colorMap_mc);
			
			dFilter = new DisplacementMapFilter ();
			dFilter.scaleX 		= 55		// pixel displacement force on X
			dFilter.scaleY 		= 55		// pixel displacement force on Y
			dFilter.componentX 	= 1			// or BitmapDataChannel.RED
			dFilter.componentY 	= 2			// or BitmapDataChannel.GREEN
			dFilter.mode		= "color"	// or DisplacementMapFilterMode.COLOR / WRAP / CLAMP / IGNORE
			dFilter.color		= 0x000000	// color of pixels when source is empty
			dFilter.alpha 		= 0			// alpha of colored pixels when source is empty
			dFilter.mapPoint	= dPoint;	// position of the filters effect area
			dFilter.mapBitmap	= dMap;		// map of colored pixels that controls the displacement
		}
		
		public function disableLens():void
		{
			image.removeEventListener(MouseEvent.ROLL_OVER, onPicOver);
			image.removeEventListener(MouseEvent.ROLL_OUT, onPicOut);
			image.removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function enableLens():void
		{
			image.addEventListener(MouseEvent.ROLL_OVER, onPicOver, false, 0, true);
			image.addEventListener(MouseEvent.ROLL_OUT, onPicOut, false, 0, true);
			image.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
		}
		
		private function onPicOver(e:MouseEvent):void 
		{
			Mouse.hide();
			image.filters = [dFilter];			
			TweenMax.to(lens_mc, .3, { transformAroundCenter:{scale:1}, autoAlpha:1 } );		
			image.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
		}
		
		private function onPicOut(e:MouseEvent):void 
		{
			Mouse.show();
			image.filters = [];			
			TweenMax.to(lens_mc, .3, { transformAroundCenter:{scale:.9}, autoAlpha:0 } );			
			image.removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			dPoint.x += ((mouseX - colorMap_mc.width / 2) - dPoint.x) * 0.25;
			dPoint.y += ((mouseY - colorMap_mc.height / 2) - dPoint.y) * 0.25;
			//lens_mc.x = dPoint.x - 17;
			lens_mc.x = dPoint.x + 229;
			//lens_mc.y = dPoint.y - 18;
			lens_mc.y = dPoint.y + 222;
			dFilter.mapPoint = dPoint;
			image.filters = [dFilter];
		}
	}
}