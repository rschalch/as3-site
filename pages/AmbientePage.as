package pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class AmbientePage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var lapic:LiquidArea;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var txt:MovieClip;
		public var pic:MovieClip;
		
		public function AmbientePage()
		{
			super();
			alpha = 0;
			txt.alpha = 0;
			
			pic.children.alpha = 0;
		}
		
		private function onResize(e:Event):void 
		{
			txt.x = pic.x + pic.width + 14;
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			
			ls = new LiquidStage(stage, 960, 600, 960, 600);
			ls.attach(title, ls.TOP_LEFT);
			
			labg = new LiquidArea(this, 0, 56, stage.stageWidth, 80);
			labg.attach(bg, { scaleMode:ScaleMode.STRETCH } );
			labg.pinCorners(ls.TOP_LEFT, ls.TOP_RIGHT);
			
			labody = new LiquidArea(this, 0, 240, stage.stageWidth, 320);
			labody.attach(bgbody, { scaleMode:ScaleMode.STRETCH } );
			labody.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			lapic = new LiquidArea(this, 260, 254, 360, 239.6);
			lapic.attach(pic, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, vAlign:AlignMode.TOP, hAlign:AlignMode.LEFT, maxWidth:700 } );
			lapic.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			stage.addEventListener(Event.RESIZE, onResize, false, 0, true);
			
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		
		override public function transitionInComplete():void 
		{
			super.transitionInComplete();
			
			onResize(null);
			
			TweenMax.to(pic.children, 3, { alpha:1, x:3, ease:Expo.easeInOut } );
			TweenMax.to(txt, .5, { alpha:1 } );
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}