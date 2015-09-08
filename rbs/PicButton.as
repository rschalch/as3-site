package rbs 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PicButton extends MovieClip
	{
		
		public function PicButton() 
		{
			buttonMode = true;
			
			TweenMax.to(this, 0, { colorMatrixFilter:{ brightness:1.1, contrast:1.2, saturation:0 } } );
			
			this.addEventListener(MouseEvent.ROLL_OVER, this_over, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, this_out, false, 0, true);
		}
		
		private function this_over(e:Event):void 
		{
			TweenMax.to(this, .3, { colorMatrixFilter:{ brightness:1, contrast:1, saturation:1 } } );
		}
		
		private function this_out(e:Event):void 
		{
			TweenMax.to(this, .3, { colorMatrixFilter:{ brightness:1.1, contrast:1.2, saturation:0 } } );
		}
		
		public function enable():void 
		{
			TweenMax.to(this, .3, { colorMatrixFilter: { brightness:1, contrast:1, saturation:1 } } );
			removeEventListener(MouseEvent.ROLL_OVER, this_over);
			removeEventListener(MouseEvent.ROLL_OUT, this_out);
		}
		
		public function disable():void 
		{
			TweenMax.to(this, .3, { colorMatrixFilter: { brightness:1.1, contrast:1.2, saturation:0 } } );
			this.addEventListener(MouseEvent.ROLL_OVER, this_over, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, this_out, false, 0, true);
		}
	}
}