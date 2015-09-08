package {
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	// Make sure "$(AppConfig)/Component Source/ActionScript 3.0/User Interface" 
	// is in your class path (so you can reference fl.controls)! 
	//
	// Edit->Preferences->ActionScript->ActionScript 3.0 Settings
	//
	// Flash doesn't set this by default (well, it should, shouldn't it?).
	import fl.controls.Button;
	import flash.events.MouseEvent;

	public class DisplayMessage extends Sprite {
		private var titleField:TextField;
		private var messageField:TextField;
		private var okBtn:Button;

		public function DisplayMessage(dTitle:String, dMessage:String, parentMC:MovieClip) {
			var format:TextFormat = new TextFormat();
            format.font = "Arial";
            format.size = 14;
			format.bold = true;
			format.color = 0xFFFFFF;
			format.align= TextFormatAlign.CENTER;
			titleField = new TextField();
			titleField.selectable = false;
			titleField.width = 300;
			titleField.height = 22;
			titleField.autoSize = TextFieldAutoSize.CENTER;
			titleField.defaultTextFormat = format;
			titleField.text = dTitle;
			if ((titleField.width + 20) > parentMC.stage.stageWidth) {
				titleField.autoSize = TextFieldAutoSize.NONE;
				titleField.width = parentMC.stage.stageWidth - 20
			}
			messageField = new TextField();
			messageField.selectable = false;
			messageField.multiline = true;
			messageField.wordWrap = true
			messageField.width = (titleField.width > 300) ? titleField.width : 300;
			messageField.height = 22;
            format.size = 12;
			format.bold = false;
			format.align= TextFormatAlign.JUSTIFY;
			messageField.defaultTextFormat = format;
			messageField.text = dMessage;
			messageField.autoSize = TextFieldAutoSize.LEFT;
			// A reference to the Button class must exist in the library of the calling movieclip!
			// Because of the Button assets!
			okBtn = new Button();
			okBtn.width = 80;
			okBtn.height = 22;
			okBtn.label = "OK";
			var boxWidth:uint = (messageField.width > titleField.width) ? messageField.width + 10: titleField.width + 10; 
			var boxHeight:uint = (messageField.height + titleField.height + okBtn.height + 30);
			var box:Shape = new Shape();
            box.graphics.beginFill(0x993300);
            box.graphics.lineStyle(1, 0xFFFFFF, 1, true);;
            box.graphics.drawRoundRect(0, 0, boxWidth, boxHeight, 8);
            box.graphics.endFill();
            addChild(box);
			titleField.x = 5
			titleField.y = 5
            addChild(titleField);
			messageField.x = 5
			messageField.y = titleField.y + titleField.height + 5;
            addChild(messageField);
			okBtn.x = (boxWidth - 80) / 2;
			okBtn.y = messageField.y + messageField.height + 5;
			okBtn.addEventListener(MouseEvent.CLICK, okClick);
			addChild(okBtn);
			this.x = (parentMC.stage.stageWidth - boxWidth) / 2;
			this.y = (parentMC.stage.stageHeight - boxHeight) / 2;
			parentMC.addChild(this);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onPressed);
			addEventListener(MouseEvent.MOUSE_UP, onUpMouse);
		}
		
		private function onUpMouse(e:MouseEvent):void 
		{
			stopDrag();
		}
		
		private function onPressed(e:MouseEvent):void 
		{
			startDrag();
		}
		private function okClick(e:MouseEvent) {
			this.parent.removeChild(this);
        }
	}
}