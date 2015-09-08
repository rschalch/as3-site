package rbs 
{
	import com.greensock.easing.Expo;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.casalib.core.IDestroyable;
	import org.casalib.display.CasaMovieClip;
	import org.casalib.layout.Distribution;
	
	public class MiniButton extends CasaMovieClip implements IDestroyable
	{
		public var code:CasaMovieClip;
		public var bmp:CasaMovieClip;
		public var bg:CasaMovieClip;
		public var swf:String;
		public var isOpen:Boolean = false;
		public var oriY:Number;
		public var oriX:Number;
		
		private var scaleFactor:Number = 0.15;
		private var types:Distribution;
		private var loader:LoaderMax;
		
		public function MiniButton() 
		{
			loader = new LoaderMax( { onComplete:imageComplete, onOpen:imageOpen, onProgress:imageLoading } );
			
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function imageOpen(e:LoaderEvent):void 
		{
			
		}
		
		private function imageLoading(e:LoaderEvent):void 
		{
			code.bg.scaleX = e.target.progress;
		}
		
		private function imageComplete(e:LoaderEvent):void 
		{
			this.addEventListener(MouseEvent.CLICK, this_click, false, 0, true);
			code.bg.scaleX = 0;
			TweenMax.to(e.target.content[0], .5, { alpha:1 } );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			
			types = this.parent as Distribution;
			
			buttonMode = true;
			scaleY = scaleX = scaleFactor;
			
			code.mouseEnabled = false;
			code.mouseChildren = false;
			code.bg.scaleX = 0;
			code.txt.alpha = 0;
		}
		
		private function this_click(e:Event):void 
		{
			types.addChildAt(this, types.numChildren - 1);
			
			if (isOpen)
				close();
			else 
			{
				closeAll();
				open();
			}
		}
		
		public function closeAll():void 
		{
			for (var i:int = 0; i < types.numChildren; i++) 
			{
				var child:MiniButton = types.getChildAt(i) as MiniButton;
				
				child.isOpen = false;
				child.close();
				TweenMax.to(this, .5, { transformAroundCenter: { scale:scaleFactor }, y:oriY, x:oriX, ease:Expo.easeInOut } );
			}
		}
		
		public function close():void 
		{
			isOpen = false;
			TweenMax.to(this, .5, { transformAroundCenter: { scale:scaleFactor }, y:oriY, x:oriX, ease:Expo.easeInOut } );
			TweenMax.to(code.txt, .3, { alpha:0, overwrite:1} );
			TweenMax.to(code.bg, .3, { scaleX:0, delay:.3, ease:Expo.easeInOut, overwrite:1 } );
		}
		
		public function open():void 
		{
			isOpen = true;
			TweenMax.to(this, .5, { transformAroundCenter: { scale:1, y:140, x:160 }, ease:Expo.easeInOut } );
			TweenMax.to(code.txt, .3, { alpha:1, delay:.5, overwrite:1} );
			TweenMax.to(code.bg, .3, { scaleX:1, delay:.3, ease:Expo.easeInOut, overwrite:1 } );
		}
		
		public function set codename(value:String):void 
		{
			code.txt.text = value;
		}
		
		public function set image(url:String):void 
		{
			loader.append(new ImageLoader(url, { container:bmp, alpha:0 } ));
			loader.load();
		}
	}
}