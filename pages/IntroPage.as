package pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import com.greensock.TimelineMax;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class IntroPage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var laimg:LiquidArea;
		private var tl:TimelineMax;
		public var image:MovieClip;
		
		public function IntroPage()
		{
			super();
			
			tl = new TimelineMax( { paused:true, onComplete:transitionInComplete, onReverseComplete:transitionOutComplete } );
			
			image.title.alpha = 0;
			image.bg.alpha = 0;
			image.btn.alpha = 0;
			TweenMax.to(image.bmp, 0, { colorMatrixFilter:{ brightness:4, contrast:3 } } );
			
			image.btn.buttonMode = true;
			image.btn.addEventListener(MouseEvent.CLICK, onclick, false, 0, true);
		}
		
		private function onclick(e:MouseEvent):void 
		{
			Gaia.api.goto(Pages.NAV);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			
			ls = new LiquidStage(stage, 960, 600, 960, 600);
			
			laimg = new LiquidArea(this, 0, 0, 960, 600);
			laimg.attach(image, {scaleMode: ScaleMode.PROPORTIONAL_INSIDE});
			laimg.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			tl.append(TweenMax.to(image.bmp, 2, { colorMatrixFilter:{ brightness:1, contrast:1 }, during:StageQuality.LOW, after:StageQuality.HIGH } ));
			tl.append(TweenMax.to(image.bg, .5, { alpha:1  } ));
			tl.append(TweenMax.to(image.title, .8, { alpha:1  } ));
			tl.append(TweenMax.to(image.btn, .5, { alpha:1  } ));
			
			tl.play();
			
			Gaia.api.getPage(Pages.INDEX).content.playST();
			Gaia.api.getPage(Pages.INDEX).content.playFX();
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			
			tl.timeScale = 2;
			tl.reverse();
			Gaia.api.getPage(Pages.INDEX).content.playFX();
		}
	}
}
