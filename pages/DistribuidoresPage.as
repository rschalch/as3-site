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
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import fl.data.DataProvider;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import utils.Services;
	
	public class DistribuidoresPage extends AbstractPage
	{	
		private var ls:LiquidStage;
		private var labg:LiquidArea;
		private var labody:LiquidArea;
		private var latxt:LiquidArea;
		
		public var bg:MovieClip;
		public var bgbody:MovieClip;
		public var title:MovieClip;
		public var mapa:MovieClip;
		public var indicator:MovieClip;
		
		public var ta:TextArea;
		//public var cbcit:ComboBox;
		
		private var service:Services;
		//private var dpcit:DataProvider;
		
		public function DistribuidoresPage()
		{
			super();
			alpha = 0;
			
			indicator.visible = false;
			indicator.mouseEnabled = false;
			indicator.mouseChildren = false;
			
			var f:Font = new calibri;
			
			var tf:TextFormat = new TextFormat();
			tf.color = 0x3f3f41;
			tf.font = f.fontName;
			tf.size = 14;
			tf.align = TextFormatAlign.JUSTIFY;
			tf.rightMargin = 20;
			
			ta.setStyle("textFormat", tf);
			ta.editable = false;
			
			mapa.clicked.add(onStateSelect);
			mapa.overed.add(onStateOver);
			
			//dpcit = new DataProvider();
			
			//cbcit.addEventListener(Event.CHANGE, onCitySelect, false, 0, true);
		}
		
		private function onResults(obj:Object):void
		{
			
		}
		
		private function onStateSelect(sigla:String, fullname:String):void 
		{
			ta.text = "Pesquisando ...";
			
			// set dispatcher to service
			service.searchdata.removeAll();
			service.searchdata.add(onState);
			
			// clear combo
			//cbcit.removeAll();
			
			service.searchAMF0("Search", "searchRepByState", this, sigla);
			
			// set combo prompts
			//cbcit.prompt = "Pesquisando ...";
			//cbcit.enabled = false;
		}
		
		private function onCitySelect(e:Event):void 
		{
			//ta.text = "Pesquisando ...";
			
			// set dispatcher to service
			service.searchdata.removeAll();
			service.searchdata.add(onResults);
			
			service.searchAMF0("Search", "getReps", this, e.currentTarget.selectedItem.data);
		}
		
		private function onStateOver(sigla:String):void 
		{
			indicator.txt.text = sigla;
		}
		
		private function onState(obj:Object):void
		{
			ta.text = "";
			
			for (var i:int = 0; i < obj.length; i++) 
			{
				var nome:String = obj[i].nome;
				var cidade:String = obj[i].cidade;
				var bairro:String = obj[i].bairro;
				var telefone:String = obj[i].telefone;
				var email:String = obj[i].email;
				var endereco:String = obj[i].endereco;
				var tipo:String = obj[i].tipo;
				
				ta.appendText("Nome: " + nome + "\n");
				ta.appendText("Cidade: " + cidade + "\n");
				if(bairro != "-")
					ta.appendText("Bairro: " + bairro + "\n");
				ta.appendText("Telefone: " + telefone + "\n");
				if(email != "-")
					ta.appendText("E-mail: " + email + "\n");
				if(endereco != "-")
					ta.appendText("Endereço: " + endereco + "\n");
				ta.appendText("Atuação: " + tipo + "\n\n");
			}
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
			
			service = new Services();
			service.searchdata.add(onState);
			
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}