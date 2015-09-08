/* inspired by the phpRemoting package of Josh Strike(josh@joshstrike.com)
but very different
*/
package {
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.Responder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.display.MovieClip;
	import DisplayMessage;

	public class AMFPHPService extends Object {
		
		private var gatewayURL:String;
		private var serviceConn:NetConnection;
		private var phpServicePath:String;
		private var callBackFunction:Function;
		private var mParentMC:MovieClip;
		private var messageXML:XML;
		private var messageArray:Array;
		private var keepOpen:Boolean;
		
		// For some dubious reasons I don't seem to be able to pass a variable
		// of type "Object" with the callback function (passed as a variable to this class)
		// with my installation of Flash, the compiler whining 
		//
		// Argument count mismatch on Untitled_fla::MainTimeline/TotalGaGa(). Expected 1, got 0.
		// 
		// when using syntax: callBackFunction.call(variable). Funny thing is, 
		// it worked for a while. Don't know why it stopped, am obviously to dumb or lazy
		// to find the cause for this "Behaviour".
		// So the public variable "result" below is a workaround for me.
		// Example (in whateveryounameit.fla): 
		// var gaga:AMFPHPService = new AMFPHPService(... TotalGaGa ...
		// function TotalGaGa():void { <= the callllback function WITHOUT anything passed 
		// trace (gaga.result);}} <= it works! Sigh.
		
		public var result:Object;

		function AMFPHPService(domain:String, gatewayPath:String, secure:Boolean, servicePath:String, messageXML:String, ko:Boolean, parent_mc:MovieClip, amftype:uint = 3) {
			var protocol:String;
			protocol = (secure) ? "https://" : "http://";
			Security.allowDomain(domain);
			gatewayURL = protocol+domain+gatewayPath;
			phpServicePath = servicePath; //actually, it's the service CLASS, 
			//but this might reside in a child directory (my classes tend to do) of 
			//"services"; ergo: path.class => phpServicePath
			mParentMC = parent_mc; 
			InitXML(messageXML);
			keepOpen = ko;
			serviceConn = new NetConnection();
			// orig: serviceConn.objectEncoding = flash.net.ObjectEncoding.AMF3; // Use AMF3 when loading bytearrays to server and AMF0 when only text
			serviceConn.objectEncoding = amftype;
			serviceConn.addEventListener(NetStatusEvent.NET_STATUS,HandleStatus,false,0,true);
			if (keepOpen) {
				serviceConn.connect(gatewayURL);
			}
		}
		public function ServiceCall(command:String, callBack:Function, ... args) {
			if (!keepOpen) {
				serviceConn.connect(gatewayURL);
			}
			callBackFunction = callBack;
			var responder:Responder = new Responder(PrepareCallback, HandleError);
			var i:Number = 2;
			var callArray:Array = new Array(phpServicePath+"."+command, responder);
			for (var j:* in args) {
				callArray[String(i)] = args[j]; //String(i) required for "strict" compiler directive
				i++;
			}
			serviceConn.call.apply(this, callArray); 
		}
		private function PrepareCallback(re:Object):void {
			if (re is Number) {
				result = Number(re);
			} else if (re is String) {
				result = String(re);
			} else {
				if (!("serverInfo" in re)) {
					for (var i:* in re) {
						if ("serverInfo" in re[i]) {
							var z:Array = ConvertRecordset(re[i]);
							re[i] = z;
						}
					}
					result= re;
				} else {
					//recordSet//
					var rsArr:Array = new Array();
					var colCount:Number = re.serverInfo.columnNames.length;
					for (var row:Number=0;row<re.serverInfo.initialData.length;row++) {
						rsArr[row] = new Array();
						for (var colIndex:* in re.serverInfo.columnNames) {
							rsArr[row][re.serverInfo.columnNames[colIndex]] = re.serverInfo.initialData[row][colIndex];
						}
					}
					result = rsArr;
				}
			}
			callBackFunction.call(); // Oooh, how I would LIKE to pass back "result"...
			if (!keepOpen) {
				serviceConn.close();
			}
		}
		private function ConvertRecordset(rs:Object):Array {
			var rsArr:Array = new Array();
			var colCount:Number = rs.serverInfo.columnNames.length;
			for (var row:Number=0;row<rs.serverInfo.initialData.length;row++) {
				rsArr[row] = new Array();
				for (var colIndex:* in rs.serverInfo.columnNames) {
					rsArr[row][rs.serverInfo.columnNames[colIndex]] = rs.serverInfo.initialData[row][colIndex];
				}
			}
			return rsArr;
		}
		private function InitXML(xmlpath:String):void {
			var xmlLdr:URLLoader = new URLLoader();
			messageXML = new XML();
			messageXML.ignoreWhitespace = true;
			xmlLdr.addEventListener(Event.COMPLETE, XMLcompleteHandler);
			xmlLdr.load(new URLRequest(xmlpath));
		}
		private function XMLcompleteHandler(event:Event):void {
			var messageXMLList:XMLList;
			var nodeXML:XML;
			messageArray = new Array();
			messageXML = XML(event.currentTarget.data);
			messageXMLList = messageXML.msg;
			for each (nodeXML in messageXMLList) {
				messageArray.push({title:nodeXML.title,message:nodeXML.message});
			}
		}
		private function HandleError(fault:Object):void {
			var mTitle:String;
			var msg:String;
			var errorDisplay:DisplayMessage;
			switch (fault.code) {
                case "NetConnection.Call.BadVersion":
					mTitle = messageArray["4"].title;
					msg = messageArray["4"].message + "\r in "+fault.details+" LINE "+fault.line;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Call.Failed":
					mTitle = messageArray["5"].title;
					msg = messageArray["5"].message + "\r in "+fault.details+" LINE "+fault.line;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Call.Prohibited":
					mTitle = messageArray["6"].title;
					msg = messageArray["6"].message + "\r in "+fault.details+" LINE "+fault.line;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
				default:
					mTitle = "Error"
					msg = String(fault.code+": "+fault.description+"\r in "+fault.details+" LINE "+fault.line);
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
			}
			if (!keepOpen) {
				serviceConn.close();
			}
		}
		private function HandleStatus(event:NetStatusEvent):void {
			var mTitle:String;
			var msg:String;
			var errorDisplay:DisplayMessage;
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    break;
                case "NetConnection.Connect.Failed":
					mTitle = messageArray["0"].title;
					msg = messageArray["0"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Connect.Rejected":
					mTitle = messageArray["1"].title;
					msg = messageArray["1"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Connect.InvalidApp":
					mTitle = messageArray["2"].title;
					msg = messageArray["2"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Connect.AppShutdown":
					mTitle = messageArray["3"].title;
					msg = messageArray["3"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Call.BadVersion":
					mTitle = messageArray["4"].title;
					msg = messageArray["4"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Call.Failed":
					mTitle = messageArray["5"].title;
					msg = messageArray["5"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
                case "NetConnection.Call.Prohibited":
					mTitle = messageArray["6"].title;
					msg = messageArray["6"].message;
					errorDisplay = new DisplayMessage(mTitle,msg,mParentMC);
                    break;
            }
		}
	}
}