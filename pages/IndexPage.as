package pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class IndexPage extends AbstractPage
	{	
		public function IndexPage()
		{
			super();
			alpha = 0;
		}
		
		public function getXML(line:String):XML
		{
			var line_xml:XML = IXml(assets[line]).xml;
			line_xml.normalize();
			return line_xml;
		}
		
		public function playST():void 
		{
			ISound(assets.st).fadeTo(.3, 0);
			ISound(assets.st).play(0, 999);
		}
		
		public function stopST():void 
		{
			ISound(assets.st).fadeTo(0, .5, stopsound);
		}
		
		private function stopsound():void 
		{
			ISound(assets.st).stop();
		}
		
		public function playFX():void 
		{
			ISound(assets.fx).play(0, 0);
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
