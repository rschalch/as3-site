package pages
{
	import com.gaiaframework.api.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.events.*;
	import com.gaiaframework.templates.AbstractPage;
	import com.greensock.easing.Expo;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	import org.casalib.layout.Distribution;
	import org.osflash.signals.Signal;
	import rbs.MiniButton;
	
	public class ProdutosPage extends AbstractPage
	{
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var lapic:LiquidArea;
		//private var swfLoader:LoaderMax;
		private var imageLoader:LoaderMax;
		private var currentAmb:String = "externa1";
		private var navpage:MovieClip;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var pic:MovieClip;
		public var phrase:MovieClip;
		public var types:Distribution;
		public var baseinfo:MovieClip;
		public var linemenu:CasaSprite;
		public var thumbs:CasaSprite;
		
		public function ProdutosPage()
		{
			super();
			
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			
			//swfLoader = new LoaderMax( { onComplete:swfComplete, onOpen:swfOpen, onProgress:swfLoading } );
			imageLoader = new LoaderMax( { onComplete:imageComplete, onOpen:imageOpen, onProgress:imageLoading } );
			
			
			// INITIALS ///////////////////////////////////////////////////////////////////////////
			
			navpage = Gaia.api.getPage(Pages.NAV).content;
			navpage.product.add(checkLine);
			
			alpha = 0;
			phrase.alpha = 0;
			types.alpha = 0;
			types.size = 400;
			types.setMargin(0, 5, 5, 0);
			baseinfo.alpha = 0;
			pic.alpha = 0;
			pic.image.loadbar.scaleX = 0;
			
			// LISTENERS ///////////////////////////////////////////////////////////////////////////
			
			linemenu.addEventListener(MouseEvent.CLICK, linemenu_click, false, 0, true);
			thumbs.addEventListener(MouseEvent.CLICK, amb_click, false, 0, true);
		}
		
		private function checkLine(obj:Object):void 
		{
			clearCurrentLine();
			
			TweenMax.to(bg, .5, { tint:navpage.color } );
		}
		
		private function clearCurrentLine():void 
		{
			linemenu.removeChildren(true, true);
			types.removeChildren(true, true);
			thumbs.removeChildren(true, true);
		}
		
		private function linemenu_click(e:MouseEvent):void 
		{
			// WHO WAS CLICKED ? ///////////////////////////////////////////////////////////////////////////
			
			switch (e.target) 
			{
				/*case linemenu.btap:
					setLine(navpage.getXML("tap"));
				break;*/
			}
		}
		
		private function setLine(collection:XML):void 
		{
			// SET COLLECTION TITLE ///////////////////////////////////////////////////////////////////////////
			title.line1.text = collection.title;
			
			// SET XMLLIST ///////////////////////////////////////////////////////////////////////////
			var list:XMLList = collection.line.children();
			
			// ORGANIZE ///////////////////////////////////////////////////////////////////////////
			for (var i:int = 0; i < list.length(); i++) 
			{
				var mb:MiniButton = new minibutton();
				mb.codename = list[i].@id;
				mb.image = collection.imagedir.text() + list[i].@file;
				types.addChild(mb);
				types.position();
			}
		}
		
		// IMAGE LOADER HANDLERS ///////////////////////////////////////////////////////////////////////////
		
		private function imageOpen(e:LoaderEvent):void 
		{
			types.mouseEnabled = false;
			types.mouseChildren = false;
			thumbs.mouseEnabled = false;
			thumbs.mouseChildren = false;
			pic.image.loadbar.scaleX = 0;
			TweenMax.to(pic.image, .5, { colorMatrixFilter:{ saturation:0 } } );
		}
		
		private function imageLoading(e:LoaderEvent):void 
		{
			pic.image.loadbar.scaleX = e.target.progress;
		}
		
		private function imageComplete(e:LoaderEvent):void 
		{
			var toBeRemoved:DisplayObject = pic.image.bmp.getChildAt(0);
			pic.image.bmp.removeChild(toBeRemoved);
			toBeRemoved = null;
			
			types.mouseEnabled = true;
			types.mouseChildren = true;
			thumbs.mouseEnabled = true;
			thumbs.mouseChildren = true;
			
			TweenMax.to(pic.image.loadbar, .3, { scaleX:0, ease:Expo.easeInOut } );
			TweenMax.to(e.target.content[0], .5, { alpha:1 } );
			TweenMax.to(pic.image, .5, { colorMatrixFilter: { saturation:1 } } );
		}
		
		
		// SWF LOADER HANDLERS ///////////////////////////////////////////////////////////////////////////
		
		private function swfOpen(e:LoaderEvent):void 
		{
			types.mouseEnabled = false;
			types.mouseChildren = false;
			thumbs.mouseEnabled = false;
			thumbs.mouseChildren = false;
			pic.image.loadbar.scaleX = 0;
			TweenMax.to(pic.image, .5, { colorMatrixFilter:{ saturation:0 } } );
		}
		
		public function swfLoading(e:LoaderEvent):void 
		{
			pic.image.loadbar.scaleX = e.target.progress;
		}
		
		private function swfComplete(e:LoaderEvent):void 
		{
			types.mouseEnabled = true;
			types.mouseChildren = true;
			thumbs.mouseEnabled = true;
			thumbs.mouseChildren = true;
			TweenMax.to(pic.image.loadbar, .3, { scaleX:0, ease:Expo.easeInOut } );
			TweenMax.to(e.target.content[0], .5, { alpha:1 } );
			TweenMax.to(pic.image, .5, { colorMatrixFilter:{ saturation:1 } } );
		}
		
		
		// CLICK HANDLERS ///////////////////////////////////////////////////////////////////////////
		
		
		private function amb_click(e:MouseEvent):void 
		{
			// SET CURRENT THUMB VAR ///////////////////////////////////////////////////////////////////////////
			
			currentAmb = e.target.name;
			
			
			// ENABLE RIGHT THUMB ///////////////////////////////////////////////////////////////////////////
			
			e.target.enable();
			
			
			// EMPTY IMAGE AND SWF LOADERS //////////////////////////////////////////////////////////////////
			
			//swfLoader.empty(true, true);
			imageLoader.empty();
			
			
			// SET IMAGE LOADER ///////////////////////////////////////////////////////////////////////////
			
			imageLoader.append(new ImageLoader("images/pisos/" + currentAmb + ".jpg", { container:pic.image.bmp, alpha:0 } ));
			imageLoader.load();
		}
		
		private function onResize(e:Event):void 
		{
			phrase.x = pic.x + pic.width + 30;
			types.x = phrase.x;
			baseinfo.y = types.y + 170;
			baseinfo.x = types.x;
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
			
			lapic = new LiquidArea(pic, 0, 0, 238.15, 320);
			lapic.attach(pic.image, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, vAlign:AlignMode.TOP, hAlign:AlignMode.LEFT } );
			lapic.pinCorners(ls.TOP_LEFT, ls.BOTTOM_RIGHT);
			
			stage.addEventListener(Event.RESIZE, onResize, false, 0, true);
			
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		
		override public function transitionInComplete():void 
		{
			super.transitionInComplete();
			
			onResize(null);
			
			TweenMax.to(phrase, .5, { alpha:1 } );
			TweenMax.to(types, .5, { alpha:1 } );
			TweenMax.to(baseinfo, .5, { alpha:1 } );
			TweenMax.to(pic, .5, { alpha:1 } );
			
			imageLoader.append(new ImageLoader("images/pisos/piso1.jpg", { container:pic.image.bmp, alpha:0 } ));
			imageLoader.load();
			
			setLine(navpage.getXML("tap"));
		}
		
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}