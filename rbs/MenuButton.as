package rbs 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MenuButton extends Sprite 
	{
		
		public function MenuButton() 
		{
			buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER, this_over, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, this_out, false, 0, true);
		}
		
		private function this_over(e:Event):void 
		{
			TweenMax.to(this, .1, { tint:0xFFCC00 } );
		}
		
		private function this_out(e:MouseEvent):void 
		{
			TweenMax.to(this, .1, { tint:0xFFFFFF } );
		}
	}
}