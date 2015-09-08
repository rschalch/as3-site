package utils 
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;
	import org.osflash.signals.Signal;
	
	public class Services extends EventDispatcher
	{
		// working on online server
		private var domain:String = "www.projectline.com.br";
		private var gateway:String = "/amfphp/gateway.php";
		
		// working locally
		//private var domain:String = "www.textiljserrano.com.br";
		//private var gateway:String = "/projectline/amfphp/gateway.php";
		
		private var messagexml:String = "messages-en.xml";
		
		public var data:Signal;
		public var searchdata:Signal;
		public var maildata:Signal;
		
		private var text_service:AMFPHPService;
		private var search_service:AMFPHPService;
		private var mail_service:AMFPHPService;
		
		public function Services()
		{
			data = new Signal();
			searchdata = new Signal();
			maildata = new Signal();
		}
		
		public function getTexts(servicePath:String, serviceCommand:String, parentMC:MovieClip):void
		{
			text_service = new AMFPHPService(domain, gateway, false, servicePath, messagexml, true, parentMC);
			text_service.ServiceCall(serviceCommand, onTextBack);
		}
		
		public function search(servicePath:String, serviceCommand:String, parentMC:MovieClip, ...args:*):void
		{
			search_service = new AMFPHPService(domain, gateway, false, servicePath, messagexml, true, parentMC);
			search_service.ServiceCall(serviceCommand, onSearchBack, args);
		}
		
		public function searchAMF0(servicePath:String, serviceCommand:String, parentMC:MovieClip, ...args:*):void
		{
			search_service = new AMFPHPService(domain, gateway, false, servicePath, messagexml, true, parentMC, ObjectEncoding.AMF0);
			search_service.ServiceCall(serviceCommand, onSearchBack, args);
		}
		
		public function mail(servicePath:String, serviceCommand:String, parentMC:MovieClip, ...args:*):void
		{
			mail_service = new AMFPHPService(domain, gateway, false, servicePath, messagexml, true, parentMC);
			mail_service.ServiceCall(serviceCommand, onMailBack, args);
		}
		
		private function onTextBack():void
		{
			data.dispatch(text_service.result);
		}
		
		private function onSearchBack():void
		{
			searchdata.dispatch(search_service.result);
		}
		
		private function onMailBack():void
		{
			maildata.dispatch(mail_service.result);
		}
	}
}