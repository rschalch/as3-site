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
	import fl.containers.UILoader;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import rbs.ui.VerticalScroller;
	import utils.Services;
	
	public class NoticiasPage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var latxt:LiquidArea;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var links:MovieClip;
		public var news:MovieClip;
		public var pic1:UILoader;
		public var pic2:UILoader;
		
		private var dl:String;
		private var vs:VerticalScroller;
		
		public function NoticiasPage()
		{
			super();
			alpha = 0;
			
			pic1 = news.pic1;
			pic2 = news.pic2;
			pic1.buttonMode = true;
			pic2.buttonMode = true;
			
			TweenMax.to(news, 0, {  autoAlpha:0 } );
			
			// LISTENERS ///////////////////////////////////////////////////////////////////////////
			
			news.back.addEventListener(MouseEvent.CLICK, back_click, false, 0, true);
			pic1.addEventListener(MouseEvent.CLICK, picClick, false, 0, true);
			pic2.addEventListener(MouseEvent.CLICK, picClick, false, 0, true);
			
			// PARAMETERS //////////////////////////////////////////////////////////////////////////
			
			dl = Gaia.api.getDeeplink().substr(1);
		}
		
		private function picClick(e:MouseEvent):void 
		{
			var currentPic:UILoader = e.currentTarget as UILoader;
			news.addChild(currentPic);
			
			if (currentPic === pic1)  
			{
				if (pic1.width > 120) 
				{
					TweenMax.to(pic1, .5, { width:120, height:80, x: 40, y:0, ease:Expo.easeInOut } );
					fadeNewsIn();
				}
				else
				{
					TweenMax.to(pic1, .5, { width:450, height:300, x: 250, y:-10, ease:Expo.easeInOut } );
					TweenMax.to(pic2, .5, { width:120, height:80, x: 40, y:90, ease:Expo.easeInOut } );
					fadeNewsOut();
				}
			}
			else
			{
				if (pic2.width > 120) 
				{
					TweenMax.to(pic2, .5, { width:120, height:80, x: 40, y:90, ease:Expo.easeInOut } );
					fadeNewsIn();
				}
				else
				{
					TweenMax.to(pic2, .5, { width:450, height:300, x: 250, y:-10, ease:Expo.easeInOut } );
					TweenMax.to(pic1, .5, { width:120, height:80, x: 40, y:0, ease:Expo.easeInOut } );
					fadeNewsOut();
				}
			}
		}
		
		private function fadeNewsIn():void 
		{
			TweenMax.to(news.title, .5, { alpha:1, delay:.25 } );
			TweenMax.to(news.subtitle, .5, { alpha:1, delay:.35 } );
			TweenMax.to(news.txt, .5, { alpha:1, delay:.5 } );
		}
		
		private function fadeNewsOut():void 
		{
			TweenMax.to(news.title, .5, { alpha:0 } );
			TweenMax.to(news.subtitle, .5, { alpha:0 } );
			TweenMax.to(news.txt, .5, { alpha:0 } );
		}
		
		private function back_click(e:MouseEvent):void 
		{
			TweenMax.to(news, .5, { autoAlpha:0, onComplete:reset } );
		}
		
		private function reset():void 
		{
			// reativa lista
			vs.x = 260;
			TweenMax.to(vs, .5, { autoAlpha:1 } );
			
			// reseta noticia principal
			news.title.text = "";
			news.subtitle.text = "";
			news.txt.text = "";
			pic1.unload();
			pic2.unload();
		}
		
		private function onList(o:Object):void 
		{
			vs = new VerticalScroller(650, 318);
			vs.x = 260;
			vs.y = 240;
			addChild(vs);
			
			for (var i:int = 0; i < o.length; i++) 
			{
				var item:MovieClip = new NewsItem();
				item.texto.text = o[i].titulo;
				item.data = {title: o[i].titulo, subtitle: o[i].subtitulo, text: o[i].texto, pic1: o[i].foto1, pic2: o[i].foto2};
				item.addEventListener(MouseEvent.CLICK, onItemClick);
				vs.add(item);
			}
		}
		
		private function onItemClick(e:MouseEvent):void 
		{
			showNews(e.target.data);
		}
		
		private function showNews(object:Object):void 
		{
			// fecha a lista
			TweenMax.to(vs, .5, { x:240, autoAlpha:0, ease:Expo.easeInOut } );
			
			// abre noticia principal
			news.title.text = object.title;
			news.subtitle.text = object.subtitle;
			news.txt.text = object.text;
			
			if (object.pic1 != null) 
			{
				pic1.source = "images/noticias/" + object.pic1;
				
				if (object.pic2 != null) 
				{
					pic2.source = "images/noticias/" + object.pic2;
				}
			}
			
			TweenMax.to(news, .5, { autoAlpha:1, delay:.5 } );
		}
		
		private function loadList():void 
		{
			var list_service:Services = new Services();
			list_service.data.add(onList);
			list_service.getTexts("News", "getNews", this);
		}
		
		private function loadNews(dl:String):void 
		{
			trace(dl);
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
			
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
			
			loadList();
			
			/*if (dl == "") 
			{
				loadList();
			}
			else 
			{
				loadNews(dl);
			}*/
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}