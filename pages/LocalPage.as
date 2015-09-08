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
	import com.google.maps.controls.MapTypeControl;
	import com.google.maps.controls.PositionControl;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapType;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.printing.PrintJobOrientation;
	
	public class LocalPage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var latxt:LiquidArea;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var txt:MovieClip;
		public var bmap:MovieClip;
		public var mapa_imp:MovieClip;
		public var bgm:MovieClip;
		public var bimp:MovieClip;
		
		private var map:Map;
		private var marker:Marker;
		
		public function LocalPage()
		{
			super();
			alpha = 0;
			
			TweenMax.to(mapa_imp, 0, { autoAlpha:0 } );
			TweenMax.to(bgm, 0, { autoAlpha:0 } );
			TweenMax.to(bimp, 0, { autoAlpha:0 } );
			
			bmap.buttonMode = true;
			bmap.addEventListener(MouseEvent.CLICK, bmap_click, false, 0, true);
			
			bgm.buttonMode = true;
			bgm.addEventListener(MouseEvent.CLICK, bgm_click, false, 0, true);
			
			bimp.buttonMode = true;
			bimp.addEventListener(MouseEvent.CLICK, bimp_click, false, 0, true);
		}
		
		private function bimp_click(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.projectline.com.br/impressao.html"), "_blank");
			
			/*var pj:PrintJob = new PrintJob();
			var po:PrintJobOptions = new PrintJobOptions(true);
			
			if ( pj.start() )
			{
				//change layout
				var a:BitmapData = new BitmapData(960, 600);
				var b:Bitmap = new Bitmap(a, PixelSnapping.ALWAYS, true);
				var c:Sprite = new Sprite();
				
				a.draw(new printPic());
				
				c.addChild(b);
				c.rotation = 90;
				addChild(c);
				
				//print
				pj.addPage(c, null, po);
				pj.send();
				
				//reset layout
				a.dispose();
				c.removeChild(b);
				removeChild(c);
				
				a = null;
				b = null;
				c = null;
				
				pj = null;
				po = null;
			}
			else
			{
				
			}*/
		}
		
		private function bgm_click(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { autoAlpha:0 } );
			TweenMax.to(mapa_imp, .3, { autoAlpha:0 } );
			TweenMax.to(bgm, .3, { autoAlpha:0 } );
			TweenMax.to(bimp, .3, { autoAlpha:0 } );
			TweenMax.to(map, .3, { autoAlpha:1, delay : .4 } );
			TweenMax.to(txt, .3, { autoAlpha:1, delay : .4 } );
			TweenMax.to(bmap, .3, { autoAlpha:1, delay : .4 } );
		}
		
		private function bmap_click(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { autoAlpha:0 } );
			TweenMax.to(map, .3, { autoAlpha:0 } );
			TweenMax.to(txt, .3, { autoAlpha:0 } );
			TweenMax.to(mapa_imp, .3, { autoAlpha:1, delay : .4 } );
			TweenMax.to(bgm, .3, { autoAlpha:1, delay : .4 } );
			TweenMax.to(bimp, .3, { autoAlpha:1, delay : .4 } );
		}
		
		private function onMapReady(e:MapEvent):void 
		{
			map.setCenter(new LatLng(-23.608116, -47.012880), 15, MapType.NORMAL_MAP_TYPE);
			map.addControl(new PositionControl());
			map.addControl(new MapTypeControl());
			map.addControl(new ZoomControl());
			
			marker = new Marker(new LatLng(-23.608116, -47.012880),
											new MarkerOptions({
												strokeStyle: new StrokeStyle({color: 0x987654}),
												fillStyle: new FillStyle({color: 0xff0000, alpha: 0.5}),
												radius: 12,
												tooltip : "Textil J. Serrano",
												hasShadow: true }));
			map.addOverlay(marker);
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			
			map = new Map();
			map.buttonMode = true;
			map.key = "ABQIAAAAab-IFvAmsabVffLQOxmx2RRwdsNbOPF1Dsn2kCafiiKnbgJgcxSaU3w1E8dmLaHo44ocKIwXUX991g";
			map.sensor = "false";
			map.height = 280;
			map.width = 360;
			map.y = 260;
			map.x = 266;
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			
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
		
		override public function transitionInComplete():void 
		{
			super.transitionInComplete();
			addChild(map);
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			removeChild(map);
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}