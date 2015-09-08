package pages
{
	import com.gaiaframework.api.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.events.*;
	import com.gaiaframework.templates.AbstractPage;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.*;
	import utils.date.formatDate;
	import utils.date.iso8601ToDate;
	import utils.Services;
	
	public class HomePage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var labuttons:LiquidArea;
		private var service:Services;
		
		public var tl:TimelineMax;
		public var tl_news:TimelineMax;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var buttons:MovieClip;
		public var news:MovieClip;
		
		public function HomePage()
		{
			super();
			alpha = 0;
			
			tl = new TimelineMax( { paused:true } );
			tl.repeat = -1;
			
			tl_news = new TimelineMax( { paused:true } );
			//tl_news.repeatDelay = 1;
			tl_news.repeat = -1;
			
			news.buttonMode = true;
			news.addEventListener(MouseEvent.CLICK, newsClick, false, 0, true);
			
			with (buttons) 
			{
				TweenMax.to(bhom, 0, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
				TweenMax.to(bper, 0, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
				TweenMax.to(bmae, 0, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
				TweenMax.to(bmai, 0, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
				TweenMax.to(brev, 0, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
				
				bhom.addEventListener(MouseEvent.ROLL_OVER, b_over, false, 0, true);
				bhom.addEventListener(MouseEvent.ROLL_OUT, b_out, false, 0, true);
				bhom.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bper.addEventListener(MouseEvent.ROLL_OVER, b_over, false, 0, true);
				bper.addEventListener(MouseEvent.ROLL_OUT, b_out, false, 0, true);
				bper.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bmae.addEventListener(MouseEvent.ROLL_OVER, b_over, false, 0, true);
				bmae.addEventListener(MouseEvent.ROLL_OUT, b_out, false, 0, true);
				bmae.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bmai.addEventListener(MouseEvent.ROLL_OVER, b_over, false, 0, true);
				bmai.addEventListener(MouseEvent.ROLL_OUT, b_out, false, 0, true);
				bmai.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				brev.addEventListener(MouseEvent.ROLL_OVER, b_over, false, 0, true);
				brev.addEventListener(MouseEvent.ROLL_OUT, b_out, false, 0, true);
				brev.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				
				
				tl.append(TweenMax.to(bhom, .8, { colorMatrixFilter: { brightness:1, contrast:1.3, saturation:1 } } ) );
				tl.append(TweenMax.to(bper, .8, { colorMatrixFilter: { brightness:1, contrast:1.3, saturation:1 } } ), -.7 );
				tl.append(TweenMax.to(bmae, .8, { colorMatrixFilter: { brightness:1, contrast:1.3, saturation:1 } } ), -.6 );
				tl.append(TweenMax.to(bmai, .8, { colorMatrixFilter: { brightness:1, contrast:1.3, saturation:1 } } ), -.5 );
				tl.append(TweenMax.to(brev, .8, { colorMatrixFilter: { brightness:1, contrast:1.3, saturation:1 } } ), -.4 );
				
				tl.append(TweenMax.to(bhom, .8, { colorMatrixFilter: { brightness:1, contrast:1, saturation:0 } } ), -.3 );	
				tl.append(TweenMax.to(bper, .8, { colorMatrixFilter: { brightness:1, contrast:1, saturation:0 } } ), -.4 );
				tl.append(TweenMax.to(bmae, .8, { colorMatrixFilter: { brightness:1, contrast:1, saturation:0 } } ), -.5 );
				tl.append(TweenMax.to(bmai, .8, { colorMatrixFilter: { brightness:1, contrast:1, saturation:0 } } ), -.6 );
				tl.append(TweenMax.to(brev, .8, { colorMatrixFilter: { brightness:1, contrast:1, saturation:0 } } ), -.7 );
				
			}
		}
		
		private function newsClick(e:MouseEvent):void 
		{
			Gaia.api.goto(Pages.NOTICIAS + "/" + e.target.id);
		}
		
		private function b_click(e:MouseEvent):void 
		{
			tl.gotoAndStop( -1);
			
			with (buttons)
			{
				switch (e.currentTarget) 
				{
					case bhom:
						Gaia.api.goto(Pages.PISOS);
					break;
					case bper:
						Gaia.api.goto(Pages.PERSIANAS);
					break;
					case bmae:
						Gaia.api.goto(Pages.EXTERNAS);
					break;
					case bmai:
						Gaia.api.goto(Pages.INTERNAS);
					break;
					case brev:
						Gaia.api.goto(Pages.PAREDES);
					break;
				}
			}
		}
		
		private function b_over(e:MouseEvent):void 
		{
			tl.gotoAndStop( -1);
			
			with (buttons)
			{
				switch (e.target) 
				{
					case bhom:
						bhom.fx.play();
						TweenMax.to(bhom, .5, { colorMatrixFilter:{ brightness:1.1, contrast:1.3, saturation:1 } } );
					break;
					case bper:
						bper.fx.play();
						TweenMax.to(bper, .5, { colorMatrixFilter:{ brightness:1.1, contrast:1.3, saturation:1 } } );
					break;
					case bmae:
						bmae.fx.play();
						TweenMax.to(bmae, .5, { colorMatrixFilter:{ brightness:1.1, contrast:1.3, saturation:1 } } );
					break;
					case bmai:
						bmai.fx.play();
						TweenMax.to(bmai, .5, { colorMatrixFilter:{ brightness:1.1, contrast:1.3, saturation:1 } } );
					break;
					case brev:
						brev.fx.play();
						TweenMax.to(brev, .5, { colorMatrixFilter:{ brightness:1.1, contrast:1.3, saturation:1 } } );
					break;
				}
			}
		}
		
		private function b_out(e:MouseEvent):void 
		{
			tl.resume();
			
			with (buttons)
			{
				switch (e.target) 
				{
					case bhom:
						TweenMax.to(bhom, .5, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
					break;
					case bper:
						TweenMax.to(bper, .5, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
					break;
					case bmae:
						TweenMax.to(bmae, .5, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
					break;
					case bmai:
						TweenMax.to(bmai, .5, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
					break;
					case brev:
						TweenMax.to(brev, .5, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:0 } } );
					break;
				}
			}
		}
		
		public function enableButtons():void 
		{
			with (buttons) 
			{
				bhom.mouseEnabled = true;
				bhom.mouseChildren = true;
				bper.mouseEnabled = true;
				bper.mouseChildren = true;
				bmae.mouseEnabled = true;
				bmae.mouseChildren = true;
				bmai.mouseEnabled = true;
				bmai.mouseChildren = true;
				brev.mouseEnabled = true;
				brev.mouseChildren = true;
			}
		}
		
		public function disableButtons():void 
		{
			with (buttons) 
			{
				bhom.mouseEnabled = false;
				bhom.mouseChildren = false;
				bper.mouseEnabled = false;
				bper.mouseChildren = false;
				bmae.mouseEnabled = false;
				bmae.mouseChildren = false;
				bmai.mouseEnabled = false;
				bmai.mouseChildren = false;
				brev.mouseEnabled = false;
				brev.mouseChildren = false;
			}
		}
		
		private function onNews(o:Object):void 
		{
			for (var i:int = 0; i < o.length; i++) 
			{
				var item:MovieClip = new NewsItem();
				//item.buttonMode = true;
				item.mouseChildren = false;
				item.id = o[i].id;
				item.titulo.text = formatDate(iso8601ToDate(o[i].data), "d^-m^-o") + "  :  " + o[i].titulo;
				item.x = (i * 900) + 900;
				news.container.addChild(item);
				
				tl_news.append(TweenMax.to(news.container, 1, { x: ( (i + 1) * -900 ), ease:Expo.easeInOut } ), (i * 1) + 1);
			}
			
			tl_news.append(TweenMax.to(news.container, .5, { alpha:0 } ), tl_news.totalTime + 2);
			
			tl_news.play();
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			
			ls = new LiquidStage(stage, 960, 600, 960, 600);
			ls.attach(title, ls.TOP_LEFT);
			ls.attach(buttons, ls.TOP_LEFT);
			ls.attach(news, ls.BOTTOM_LEFT);
			
			labg = new LiquidArea(this, 0, 56, stage.stageWidth, 80);
			labg.attach(bg, { scaleMode:ScaleMode.STRETCH } );
			labg.pinCorners(ls.TOP_LEFT, ls.TOP_RIGHT);
			
			labody = new LiquidArea(this, 0, 240, stage.stageWidth, 320);
			labody.attach(bgbody, { scaleMode:ScaleMode.STRETCH } );
			labody.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			labuttons = new LiquidArea(this, 246, 240, 679, 243);
			labuttons.attach(buttons, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, vAlign:AlignMode.TOP, hAlign:AlignMode.LEFT } );
			labuttons.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			TweenMax.to(this, 0.5, { alpha:1, onComplete:transitionInComplete } );
			
			service = new Services();
			service.data.add(onNews);
			service.getTexts("News", "getNews", this);
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			
			tl.gotoAndStop( -1);
			
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
		
		override public function transitionInComplete():void 
		{
			super.transitionInComplete();
			tl.play();
		}
	}
}
