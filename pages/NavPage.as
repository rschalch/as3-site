package pages
{
	import com.frigidfish.FlashPHP;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.easing.Expo;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.PinPoint;
	import com.greensock.layout.ScaleMode;
	import com.greensock.TimelineMax;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.text.Font;
	import flash.text.TextFormat;
	import utils.cookie.getCookie;
	import utils.cookie.setCookie;
	import utils.validation.isEmail;
	
	public class NavPage extends AbstractPage
	{
		public var bg:MovieClip;
		public var mainmenu:MovieClip;
		public var besp:MovieClip;
		public var line:MovieClip;
		public var body:MovieClip;
		public var form:MovieClip;
		public var espform:MovieClip;
		public var ma:ComboBox;
		
		private var ls:LiquidStage;
		
		private var latop:LiquidArea;
		private var laline:LiquidArea;
		private var laformbg:LiquidArea;
		
		private var espflag:Boolean = false;
		
		private var tlhom:TimelineMax;
		private var tlpro:TimelineMax;
		private var tlamb:TimelineMax;
		private var tldad:TimelineMax;
		
		private var sendvars:Object;
		private var phpData:*;
		
		private var sip:Boolean = true;
		
		public function NavPage()
		{
			super();
			
			/////////////////////////////////////// INITIALS ///////////////////////////////////////
			
			sendvars = {};
			
			alpha = 0;
			
			mainmenu.bhom.bg.scaleY = 0;
			TweenMax.to(mainmenu.bhom.ntc, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bhom.sob, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bhom.ser, 0, { autoAlpha: 0 } );
			
			mainmenu.bpro.bg.scaleY = 0
			TweenMax.to(mainmenu.bpro.pis, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bpro.per, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bpro.mae, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bpro.mai, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bpro.rev, 0, { autoAlpha: 0 } );
			
			mainmenu.bamb.bg.scaleY = 0;
			TweenMax.to(mainmenu.bamb.pvc, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bamb.res, 0, { autoAlpha: 0 } );
			
			mainmenu.bdad.bg.scaleY = 0;
			TweenMax.to(mainmenu.bdad.lau, 0, { autoAlpha: 0 } );
			TweenMax.to(mainmenu.bdad.ins, 0, { autoAlpha: 0 } );
			
			var f:Font = new myFont;
			
			var tf:TextFormat = new TextFormat();
			tf.color = 0xFFFFFF;
			tf.font = f.fontName;
			tf.size = 12;
			
			espform.te.txt.restrict = "0-9 ()rR./ \\-";
			
			ma = espform.ma;
			ma.textField.setStyle("textFormat", tf);
			
			ma.prompt = "Selecione :";
			ma.addItem( { label:"Catálogos" } );
			ma.addItem( { label:"Amostras" } );
			ma.addItem( { label:"Distribuidores" } );
			ma.addItem( { label:"Orçamento" } );
			ma.addItem( { label:"Outros" } );
			
			
			var ta:TextArea = espform.ta;
			ta.setStyle("textFormat", tf);
			
			
			/////////////////////////////////////// TIMELINES ///////////////////////////////////////
			
			tlhom = new TimelineMax({paused: true});
			tlhom.append(TweenMax.to(mainmenu.bhom.bg, .3, {scaleY: 1, ease: Expo.easeInOut}));
			tlhom.append(TweenMax.to(mainmenu.bhom.ntc, .3, {autoAlpha: 1}), -.1);
			tlhom.append(TweenMax.to(mainmenu.bhom.sob, .3, {autoAlpha: 1}), -.15);
			tlhom.append(TweenMax.to(mainmenu.bhom.ser, .3, {autoAlpha: 1}), -.2);
			
			tlpro = new TimelineMax({paused: true});
			tlpro.append(TweenMax.to(mainmenu.bpro.bg, .3, {scaleY: 1, ease: Expo.easeInOut}));
			tlpro.append(TweenMax.to(mainmenu.bpro.pis, .3, {autoAlpha: 1}), -.1);
			tlpro.append(TweenMax.to(mainmenu.bpro.per, .3, {autoAlpha: 1}), -.15);
			tlpro.append(TweenMax.to(mainmenu.bpro.mae, .3, {autoAlpha: 1}), -.2);
			tlpro.append(TweenMax.to(mainmenu.bpro.mai, .3, {autoAlpha: 1}), -.25);
			tlpro.append(TweenMax.to(mainmenu.bpro.rev, .3, { autoAlpha: 1 } ), -.3);
			
			tlamb = new TimelineMax({paused: true});
			tlamb.append(TweenMax.to(mainmenu.bamb.bg, .3, {scaleY: 1, ease: Expo.easeInOut}));
			tlamb.append(TweenMax.to(mainmenu.bamb.pvc, .3, {autoAlpha: 1}), -.1);
			tlamb.append(TweenMax.to(mainmenu.bamb.res, .3, { autoAlpha: 1 } ), -.2);
			
			tldad = new TimelineMax({paused: true});
			tldad.append(TweenMax.to(mainmenu.bdad.bg, .3, {scaleY: 1, ease: Expo.easeInOut}));
			tldad.append(TweenMax.to(mainmenu.bdad.lau, .3, {autoAlpha: 1}), -.1);
			tldad.append(TweenMax.to(mainmenu.bdad.ins, .3, {autoAlpha: 1}), -.2);
			
			// LISTENERS ///////////////////////////////////////////////////////////////////////////
			
			body.sc.addEventListener(MouseEvent.CLICK, sc_click, false, 0, true);
			besp.addEventListener(MouseEvent.CLICK, besp_click, false, 0, true);
			espform.benv.addEventListener(MouseEvent.CLICK, benv_click, false, 0, true);
			
			// FORM INDEX ///////////////////////////////////////////////////////////////////////////
			
			with (espform)
			{
				no.txt.tabIndex = 1;
				ml.txt.tabIndex = 2;
				te.txt.tabIndex = 3;
				em.txt.tabIndex = 4;
				ca.txt.tabIndex = 5;
				en.txt.tabIndex = 6;
				ci.txt.tabIndex = 7;
				ma.tabIndex = 8;
				ta.tabIndex = 9;
				benv.tabEnabled = true;
				benv.tabIndex = 10;
			}
			
			// MAINMENU ///////////////////////////////////////////////////////////////////////////
			
			with (mainmenu)
			{
				bhom.addEventListener(MouseEvent.ROLL_OVER, bhom_over, false, 0, true);
				bhom.addEventListener(MouseEvent.ROLL_OUT, bhom_out, false, 0, true);
				bhom.hit.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bhom.ntc.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bhom.sob.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bhom.ser.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bpro.addEventListener(MouseEvent.ROLL_OVER, bpro_over, false, 0, true);
				bpro.addEventListener(MouseEvent.ROLL_OUT, bpro_out, false, 0, true);
				bpro.pis.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bpro.per.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bpro.mae.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bpro.mai.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bpro.rev.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bamb.addEventListener(MouseEvent.ROLL_OVER, bamb_over, false, 0, true);
				bamb.addEventListener(MouseEvent.ROLL_OUT, bamb_out, false, 0, true);
				bamb.pvc.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bamb.res.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bdad.addEventListener(MouseEvent.ROLL_OVER, bdad_over, false, 0, true);
				bdad.addEventListener(MouseEvent.ROLL_OUT, bdad_out, false, 0, true);
				bdad.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bdad.lau.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				bdad.ins.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bloc.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
				bdis.addEventListener(MouseEvent.CLICK, b_click, false, 0, true);
				
			}
		}
		
		private function sc_click(e:MouseEvent):void 
		{
			var indexpage:MovieClip = Gaia.api.getPage(Pages.INDEX).content;
			
			if (sip) 
			{
				indexpage.stopST();
				body.sc.gotoAndStop(2);
				sip = false;
			}
			else 
			{
				indexpage.playST();
				body.sc.gotoAndStop(1);
				sip = true;
			}
		}
		
		private function benv_click(e:MouseEvent):void 
		{
			with (espform) 
			{
				if (no.txt.text == "") 
				{
					msg.text = "Preencha o nome.";
				}
				else if(ml.txt.text == "")
				{
					msg.text = "Preencha o e-mail.";
				}
				else if(!isEmail(ml.txt.text))
				{
					msg.text = "E-mail inválido.";
				}
				else if(te.txt.text == "")
				{
					msg.text = "Preencha o telefone.";
				}
				else if(em.txt.text == "")
				{
					msg.text = "Preencha o nome de sua empresa.";
				}
				else if(en.txt.text == "")
				{
					msg.text = "Preencha o endereço.";
				}
				else if(ci.txt.text == "")
				{
					msg.text = "Preencha a Cidade e Estado.";
				}
				else if(ma.text == "Selecione :")
				{
					msg.text = "Selecione o assunto deste contato.";
				}
				else 
				{
					msg.text = "Enviando ...";
					
					sendvars.nome = no.txt.text;
					sendvars.email = ml.txt.text;
					sendvars.telefone = te.txt.text;
					sendvars.empresa = em.txt.text;
					sendvars.cargo = ca.txt.text;
					sendvars.endereco = en.txt.text;
					sendvars.cidade = ci.txt.text;
					sendvars.assunto = ma.text;
					sendvars.mensagem = ta.text;
					
					var flashPHP:FlashPHP = new FlashPHP("http://www.projectline.com.br/contact.php", sendvars);
					flashPHP.addEventListener("ready", processPHPVars);
				}
			}
		}
		
		private function processPHPVars(e:Event):void 
		{
			phpData = e.target.receivedVars;
			
			if (phpData.resulto == "ok") 
			{
				espform.msg.text = "Mensagem enviada com sucesso.";
				setCookie("access", "granted");
				resetForm();
			}
			else 
			{
				espform.msg.text = "Erro no envio, tente mais tarde.";
			}
		}
		
		private function b_click(e:MouseEvent):void
		{
			if (espflag) 
			{
				closeForm();
				espflag = false;
			}
			
			switch (e.currentTarget)
			{
				case mainmenu.bhom.hit: 
					Gaia.api.goto(Pages.HOME);
					break;
				case mainmenu.bhom.ntc: 
					Gaia.api.goto(Pages.NOTICIAS);
					break;	
				case mainmenu.bhom.sob: 
					Gaia.api.goto(Pages.SOBRE);
					break;
				case mainmenu.bhom.ser: 
					Gaia.api.goto(Pages.SERRANO);
					break;
				case mainmenu.bpro.pis:
					Gaia.api.goto(Pages.PISOS);					
					break;
				case mainmenu.bpro.per: 
					Gaia.api.goto(Pages.PERSIANAS);
					break;
				case mainmenu.bpro.mae: 
					Gaia.api.goto(Pages.EXTERNAS);
					break;
				case mainmenu.bpro.mai: 
					Gaia.api.goto(Pages.INTERNAS);
					break;
				case mainmenu.bpro.rev: 
					Gaia.api.goto(Pages.PAREDES);
					break;
				case mainmenu.bamb.pvc: 
					Gaia.api.goto(Pages.PVC);
					break;
				case mainmenu.bamb.res: 
					Gaia.api.goto(Pages.AMBIENTE);
					break;
				case mainmenu.bdad.lau: 
					Gaia.api.goto(Pages.LAUDOS);
					break;
				case mainmenu.bdad.ins: 
					Gaia.api.goto(Pages.INSTALACAO);
					break;
				case mainmenu.bloc:
					Gaia.api.goto(Pages.LOCAL);
					break;
				case mainmenu.bdis: 
					Gaia.api.goto(Pages.DISTRIBUIDORES);
					break;
			}
		}
		
		private function bhom_over(e:MouseEvent):void
		{
			tlhom.play();
		}
		
		private function bhom_out(e:MouseEvent):void
		{
			tlhom.reverse();
		}
		
		private function bpro_over(e:MouseEvent):void
		{
			tlpro.play();
		}
		
		private function bpro_out(e:MouseEvent):void
		{
			tlpro.reverse();
		}
		
		private function bamb_over(e:MouseEvent):void 
		{
			tlamb.play()
		}
		
		private function bamb_out(e:MouseEvent):void 
		{
			tlamb.reverse();
		}
		
		private function bdad_over(e:MouseEvent):void 
		{
			tldad.play();
		}
		
		private function bdad_out(e:MouseEvent):void 
		{
			tldad.reverse();
		}
		
		private function besp_click(e:MouseEvent):void
		{
			var child:MovieClip = Gaia.api.getPage(Gaia.api.getCurrentBranch()).content;
			
			if (espflag)
			{
				resetForm();
				
				espflag = false;
				e.currentTarget.plus.gotoAndStop(1);
				TweenMax.to(body, .8, {y: 98, ease: Expo.easeInOut, onStart: checkPageContent});
				TweenMax.to(espform, .8, {y: -210, ease: Expo.easeInOut});
				TweenMax.to(laformbg, .8, {y: -224, ease: Expo.easeInOut});
				TweenMax.to(child, .8, {y: 0, ease: Expo.easeInOut});
			}
			
			else
			{
				espflag = true;
				e.currentTarget.plus.gotoAndStop(2);
				TweenMax.to(body, .8, { y: 378, ease: Expo.easeInOut, onStart: checkPageContent } );
				TweenMax.to(espform, .8, { y: 70, ease: Expo.easeInOut } );
				TweenMax.to(laformbg, .8, { y: 56, ease: Expo.easeInOut } );
				TweenMax.to(child, .8, { y: 280, ease: Expo.easeInOut } );
			}
		}
		
		private function closeForm():void 
		{
			resetForm();
			
			var child:MovieClip = Gaia.api.getPage(Gaia.api.getCurrentBranch()).content;
			
			besp.plus.gotoAndStop(1);
			TweenMax.to(body, .8, { y: 98, ease: Expo.easeInOut } );
			TweenMax.to(espform, .8, { y: -210, ease: Expo.easeInOut } );
			TweenMax.to(laformbg, .8, { y: -224, ease: Expo.easeInOut } );
			TweenMax.to(child, .8, { y: 0, ease: Expo.easeInOut } );
		}
		
		private function checkPageContent():void
		{
			if (Gaia.api.getCurrentBranch() == Pages.HOME)
			{
				if (espflag)
				{
					Gaia.api.getPage(Pages.HOME).content.tl.gotoAndStop( -1);
					Gaia.api.getPage(Pages.HOME).content.disableButtons();
				}
				else
				{
					Gaia.api.getPage(Pages.HOME).content.tl.resume();
					Gaia.api.getPage(Pages.HOME).content.enableButtons();
				}
			}
		}
		
		public function checkCookie():String
		{
			return getCookie("access");
		}
		
		private function resetForm():void 
		{
			espform.no.txt.text = "";
			espform.ml.txt.text = "";
			espform.te.txt.text = "";
			espform.em.txt.text = "";
			espform.ca.txt.text = "";
			espform.en.txt.text = "";
			espform.ci.txt.text = "";
			ma.textField.text = "Selecione :";
			espform.ta.text = "";
			
			if (espform.msg.text != "Mensagem enviada com sucesso.") 
			{
				espform.msg.text = "*preenchimento obrigatório.";
			}
		}
		
		override public function transitionIn():void
		{
			super.transitionIn();
			
			stage.stageFocusRect = false;
			
			ls = new LiquidStage(stage, 960, 600, 960, 600);
			ls.attach(mainmenu, ls.TOP_LEFT);
			ls.attach(body.htpvc, ls.TOP_RIGHT);
			ls.attach(form, ls.TOP_LEFT);
			ls.attach(espform, ls.TOP_LEFT);
			ls.attach(besp, ls.TOP_RIGHT);
			ls.attach(body.sc, ls.BOTTOM_LEFT);
			ls.attach(body.copyright, ls.BOTTOM_RIGHT);
			ls.attach(body.logo, ls.TOP_LEFT);
			ls.attach(body.serrano, ls.BOTTOM_LEFT);
			
			latop = new LiquidArea(this, 0, 0, stage.stageWidth, 56);
			latop.attach(bg, { scaleMode: ScaleMode.STRETCH } );
			latop.pinCorners(ls.TOP_LEFT, ls.TOP_RIGHT);
			
			laline = new LiquidArea(this, 245, 0, 1, stage.stageHeight);
			laline.attach(line, { scaleMode: ScaleMode.STRETCH } );
			laline.pinCorners(ls.TOP_LEFT, ls.BOTTOM_LEFT);
			
			laformbg = new LiquidArea(this, 0, -224, stage.stageWidth, 280);
			laformbg.attach(form, { scaleMode: ScaleMode.STRETCH } );
			laformbg.pinCorners(ls.TOP_LEFT, ls.TOP_RIGHT);
			
			TweenMax.to(this, 0.5, { alpha: 1, onComplete: transitionInComplete } );
		}
		
		override public function transitionOut():void
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, { alpha: 0, onComplete: transitionOutComplete } );
		}
	}
}
