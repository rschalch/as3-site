package rbs.ui 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class VerticalScroller extends MovieClip 
	{
		private var speed:Number = 0.2;
		
		private var _w:Number;
		private var _h:Number;
		private var _gap:int;
		private var _margin:int;
		
		private var ydist:Number;
		private var rm:Number;
		
		private var _mask:Sprite;
		private var holder:Sprite;
		private var bg:Sprite;
		private var _do:DisplayObject;
		
		public function VerticalScroller(w:Number, h:Number, gap:int = 0) 
		{
			_w = w;
			_h = h;
			_gap = gap;
			
			bg = new Sprite();
			bg.graphics.beginFill(0xFFFFFF, 0);
			bg.graphics.drawRect(0, 0, w, h);
			bg.graphics.endFill();
			addChild(bg);
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0xFFFFFF, 0);
			_mask.graphics.drawRect(0, 0, w, h);
			_mask.graphics.endFill();
			addChild(_mask);
			
			holder = new Sprite();
			holder.addEventListener(Event.ADDED, onAdded, false, 0, true);
			holder.mask = _mask;
			holder.y = _gap;
			addChild(holder);
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function onAdded(e:Event):void 
		{
			if (e.target != this) 
			{
				_do = e.target as DisplayObject;
				_do.y = (_do.height * (holder.numChildren - 1)) + (holder.numChildren - 1) * _gap;
				TweenMax.fromTo(_do, .5, { alpha:0 }, { alpha:1 } );
				
				if (holder.height > _h) 
				{
					addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
				}
				else
				{
					removeEventListener(Event.ENTER_FRAME, loop);
				}
			}
		}
		
		private function loop(e:Event):void 
		{
			/*var percentage:Number = mouseY /(_h - _gap - (_do.height * 2));
			var targetY:Number = (holder.height - (_h + _gap)) * ( - percentage );
			holder.y += (targetY - (holder.y + _gap) + (_do.height * 2) ) *  speed;
			
			if (holder.y > _gap) holder.y = _gap;
			if (holder.y < ( _h - holder.height - _gap )) holder.y = _h - holder.height - _gap;*/
			
			var percentage:Number = mouseY /(_h - _gap);
			var targetY:Number = (holder.height - (_h + _gap)) * ( - percentage );
			holder.y += (targetY - (holder.y + _gap) ) *  speed;
			
			if (holder.y > _gap) holder.y = _gap;
			if (holder.y < ( _h - holder.height - _gap )) holder.y = _h - holder.height - _gap;
		}
		
		public function add(_do:DisplayObject)
		{
			holder.addChild(_do);
		}
		
		public function clear():void
		{
			var i:int = holder.numChildren;
			
			while (i--)
			{
				holder.removeChildAt(i);
			}
		}
	}
}