package pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class LaudosPage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var lapic:LiquidArea;
		private var navpage:MovieClip;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var txt:MovieClip;
		public var docs:MovieClip;
		public var pic:MovieClip;
		
		public function LaudosPage()
		{
			super();
			alpha = 0;
			
			navpage = Gaia.api.getPage(Pages.NAV).content;
			
			TweenMax.to(docs, 0, { autoAlpha:0 } );
			
			txt.link.addEventListener(MouseEvent.CLICK, onLink);
		}
		
		private function onLink(e:MouseEvent):void 
		{
			TweenMax.to(txt, .5, { autoAlpha:0 } );
			TweenMax.to(docs, .5, { autoAlpha:1, delay:.5 } );
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
			
			lapic = new LiquidArea(this, 656, 266, 275.4, 178.1);
			lapic.attach(pic, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, vAlign:AlignMode.TOP, hAlign:AlignMode.LEFT, maxWidth:420 } );
			lapic.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}