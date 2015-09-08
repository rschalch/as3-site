/*****************************************************************************************************
* Gaia Framework for Adobe Flash ©2007-2009
* Author: Steven Sacks
*
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is released under the MIT License:
* http://www.opensource.org/licenses/mit-license 
*****************************************************************************************************/

package pages
{
	import com.gaiaframework.events.*;
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class PreloaderScaffold extends MovieClip
	{
		public var MC_Bar:MovieClip;
		
		public function PreloaderScaffold()
		{
			super();
			alpha = 0;
			visible = false;
			mouseEnabled = mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(null);
		}
		
		private function onResize(e:Event):void 
		{
			this.parent.width = stage.stageWidth;
		}
		public function transitionIn():void
		{
			MC_Bar.scaleX = 0;
			TweenMax.to(this, .2, { autoAlpha:1 } );
		}
		public function transitionOut():void
		{
			TweenMax.to(this, .3, { autoAlpha:0 } );
		}
		public function onProgress(event:AssetEvent):void
		{
			// if bytes, don't show if loaded = 0, if not bytes, don't show if perc = 0
			// the reason is because all the files might already be loaded so no need to show preloader
			visible = event.bytes ? (event.loaded > 0) : (event.perc > 0);
			
			// progress bar scale times percentage (0-1)
			MC_Bar.scaleX = event.perc;
		}
	}
}
