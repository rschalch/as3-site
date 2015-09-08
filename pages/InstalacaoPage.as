package pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.BlitMask;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class InstalacaoPage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var initial:MovieClip;
		public var container:MovieClip;
		public var bnext:MovieClip;
		
		private var content:MovieClip;
		private var bm:BlitMask;
		
		public function InstalacaoPage()
		{
			super();
			alpha = 0;
			
			container.bnext.buttonMode = true;
			container.bprev.buttonMode = true;
			TweenMax.to(container, 0, { autoAlpha:0 } );
			
			initial.bpis.buttonMode = true;
			//initial.bper.buttonMode = true;
			//initial.brev.buttonMode = true;
			
			initial.addEventListener(MouseEvent.CLICK, content_click, false, 0, true);
		}
		
		private function content_click(e:MouseEvent):void 
		{
			switch (e.target.name) 
			{
				case "bpis":
					TweenMax.to(initial, .3, { autoAlpha:0, onComplete:showContainer, onCompleteParams:[pisos] } );
				break;
				case "bper":
					
				break;
				case "brev":
					
				break;
			}
		}
		
		private function showContainer(c:Class):void 
		{
			content = new c;
			container.place.addChild(content);
			container.bprev.visible = false;
			
			TweenMax.to(container, .5, { autoAlpha:1, onComplete:setControls } );
		}
		
		private function setControls():void
		{
			container.bnext.addEventListener(MouseEvent.CLICK, next_click);
			container.bprev.addEventListener(MouseEvent.CLICK, prev_click);
			
			bm = new BlitMask(content, 0, 0, 714, 320);
		}
		
		private function prev_click(e:MouseEvent):void 
		{
			if (bm.scrollX > 0)
			{
				TweenMax.to(content, 1, {x:"714", onInit:startSlide, onUpdate:bm.update, onComplete:stopSlide, ease:Expo.easeInOut});
			}
		}
		
		private function next_click(e:MouseEvent):void 
		{
			if (bm.scrollX < 1)
			{
				TweenMax.to(content, 1, {x:"-714", onInit:startSlide, onUpdate:bm.update, onComplete:stopSlide, ease:Expo.easeInOut});
			}
		}
		
		private function startSlide():void 
		{
			container.bnext.mouseEnabled = false;
			container.bprev.mouseEnabled = false;
			container.bnext.mouseChildren = false;
			container.bprev.mouseChildren = false;
			bm.enableBitmapMode();
		}
		
		private function stopSlide():void 
		{
			container.bnext.mouseEnabled = true;
			container.bprev.mouseEnabled = true;
			container.bnext.mouseChildren = true;
			container.bprev.mouseChildren = true;
			bm.disableBitmapMode();
			
			bm.scrollX == 1 ? container.bnext.visible = false : container.bnext.visible = true;
			bm.scrollX == 0 ? container.bprev.visible = false : container.bprev.visible = true;
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
			
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}