package pages 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import org.osflash.signals.Signal;
	
	public class Mapa extends MovieClip
	{
		public var _am:MovieClip;
		public var _pa:MovieClip;
		public var _pr:MovieClip;
		public var _pe:MovieClip;
		public var _pi:MovieClip;
		public var _to:MovieClip;
		public var _go:MovieClip;
		public var _rs:MovieClip;
		public var _rj:MovieClip;
		public var _ro:MovieClip;
		public var _rn:MovieClip;
		public var _ms:MovieClip;
		public var _mt:MovieClip;
		public var _rr:MovieClip;
		public var _sp:MovieClip;
		public var _se:MovieClip;
		public var _mg:MovieClip;
		public var _es:MovieClip;
		public var _ba:MovieClip;
		public var _al:MovieClip;
		public var _ma:MovieClip;
		public var _pb:MovieClip;
		public var _ce:MovieClip;
		public var _ap:MovieClip;
		public var _ac:MovieClip;
		public var _sc:MovieClip;
		public var _df:MovieClip;
		
		private var indicator:MovieClip;
		public var outline:MovieClip;
		
		public var clicked:Signal;
		public var overed:Signal;
		
		private var _do:DisplayObject;
		
		public function Mapa() 
		{
			outline.mouseEnabled = false;
			outline.mouseChildren = false;
			
			clicked = new Signal();
			overed = new Signal();
			
			addEventListener(MouseEvent.CLICK, stateChoice, false, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, onMove, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, onOut, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, onAdded, false, 0, true);
			
			_sp.sigla = "SP";
			_sp.fullName = "SÃO PAULO";
			
			_rj.sigla = "RJ";
			_rj.fullName = "RIO DE JANEIRO";
			
			_es.sigla = "ES";
			_es.fullName = "ESPÍRITO SANTO";
			
			_mg.sigla = "MG";
			_mg.fullName = "MINAS GERAIS";
			
			_pr.sigla = "PR";
			_pr.fullName = "PARANÁ";
			
			_sc.sigla = "SC";
			_sc.fullName = "SANTA CATARINA";
			
			_rs.sigla = "RS";
			_rs.fullName = "RIO GRANDE DO SUL";
			
			_ba.sigla = "BA";
			_ba.fullName = "BAHIA";
			
			_se.sigla = "SE";
			_se.fullName = "SERGIPE";
			
			_ms.sigla = "MS";
			_ms.fullName = "MATO GROSSO DO SUL";
			
			_mt.sigla = "MT";
			_mt.fullName = "MATO GROSSO";
			
			_pe.sigla = "PE";
			_pe.fullName = "PERNAMBUCO";
			
			_pb.sigla = "PB";
			_pb.fullName = "PARAÍBA";
			
			_pi.sigla = "PI";
			_pi.fullName = "PIAUÍ";
			
			_ma.sigla = "MA";
			_ma.fullName = "MARANHÃO";
			
			_pa.sigla = "PA";
			_pa.fullName = "PARÁ";
			
			_ce.sigla = "CE";
			_ce.fullName = "CEARÁ";
			
			_ap.sigla = "AP";
			_ap.fullName = "AMAPÁ";
			
			_rr.sigla = "RR";
			_rr.fullName = "RORAIMA";
			
			_ac.sigla = "AC";
			_ac.fullName = "ACRE";
			
			_df.sigla = "DF";
			_df.fullName = "DISTRITO FEDERAL";
			
			_al.sigla = "AL";
			_al.fullName = "ALAGOAS";
			
			_rn.sigla = "RN";
			_rn.fullName = "RIO GRANDE DO NORTE";
			
			_ro.sigla = "RO";
			_ro.fullName = "RONDÔNIA";
			
			_to.sigla = "TO";
			_to.fullName = "TOCANTINS";
			
			_go.sigla = "GO";
			_go.fullName = "GOIÁS";
			
			_am.sigla = "AM";
			_am.fullName = "AMAZONAS";
			
			for (var i:int = 0; i < numChildren - 1; i++) 
			{
				if (getChildAt(i).name.indexOf("outline") != 0) 
				{
					//TweenMax.to(getChildAt(i), 0, {tint:0xFFFFFF} );
					getChildAt(i).addEventListener(MouseEvent.ROLL_OVER, stateOver, false, 0, true);
					getChildAt(i).addEventListener(MouseEvent.ROLL_OUT, stateOut, false, 0, true);
				}
			}
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_do = this.parent;
			
			indicator = MovieClip(this.parent.getChildByName("indicator"));
		}
		
		private function onMove(e:MouseEvent):void 
		{
			indicator.visible = true;
			indicator.x = _do.mouseX;
			indicator.y = _do.mouseY;
			Mouse.hide();
			e.updateAfterEvent();
		}
		
		private function onOut(e:MouseEvent):void 
		{
			indicator.visible = false;
			Mouse.show();
		}
		
		private function stateOver(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .1, { tint:0x475E88 } );
			overed.dispatch(MovieClip(e.target).sigla);
		}
		
		private function stateOut(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { tint:0xFFFFFF } );
			overed.dispatch("");
		}
		
		private function stateChoice(e:MouseEvent):void 
		{			
			// reseta cor do restante dos estados e devolve listeners
			for (var i:int = 0; i < numChildren - 1; i++) 
			{
				if (getChildAt(i).name.indexOf("outline") != 0) 
				{
					TweenMax.to(getChildAt(i), 0, { tint:0xFFFFFF } );
					getChildAt(i).addEventListener(MouseEvent.ROLL_OVER, stateOver, false, 0, true);
					getChildAt(i).addEventListener(MouseEvent.ROLL_OUT, stateOut, false, 0, true);
				}
			}
			
			// desabilita rollout e rollover no estado selecionado
			e.target.removeEventListener(MouseEvent.ROLL_OUT, stateOut);
			e.target.removeEventListener(MouseEvent.ROLL_OVER, stateOver);
			
			// colore selecionado e dispara o evento do Signal			
			if (e.target != this) 
			{
				TweenMax.to(e.target, .5, { tint:0x475E88 });
				clicked.dispatch(MovieClip(e.target).sigla, MovieClip(e.target).fullName);
			}
		}
	}
}