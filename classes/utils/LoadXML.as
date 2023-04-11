/**
 * BullDOG 2.1.0 - Flash Extension Framework <http://www.luizsegundo.com.br/bulldog>
 *
 * BullDOG is (c) 2008-2010 Luiz Segundo
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 *
 * 
 * Written by: Luiz Segundo <http://www.luizsegundo.com.br>
 *
 **/

package utils
{
	import bulldog.debug.BullDogException;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class LoadXML extends MovieClip
	{
		//Private vars
		private var _url:String;
		private	var _urlRequest:URLRequest;
		private	var _loader:URLLoader;
		private var _xml:XML;
		
		//Public event constants
		public static const LOAD_COMPLETE:String = "loadComplete";
		public static const LOAD_ERROR:String = "loadError";
		public static const LOAD_IOERROR:String = "loadIoError";		
		public static const LOAD_PROGRESS:String = "loadProgress";
		public static const SCROLLING:String = "scrolling";

		//Constructor
		public function LoadXML(url:String)
		{
			_url = url;
			Load();
		}
		public function Load():void
		{
			_urlRequest = new URLRequest(_url);
			try 
			{
				_loader = new URLLoader(_urlRequest);	
			}
			catch (e:Error)
			{
				throw new BullDogException(BullDogException.FILE_ESTRUCTURE ,e.message);
			}
			
			handleEvens();
		}
		
		private function handleEvens():void
		{
			_loader.addEventListener(Event.COMPLETE, LoadComplete);			
			_loader.addEventListener(ErrorEvent.ERROR, LoadError);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, LoadIoError);
			_loader.addEventListener(ProgressEvent.PROGRESS,LoadProgress);
		}
		
		private function LoadProgress(e:ProgressEvent):void 
		{
			//dispara o evento ao carregar xml
			dispatchEvent(new ProgressEvent(LoadXML.LOAD_PROGRESS));			
		}
		
		private function LoadError(e:ErrorEvent):void 
		{
			//dispara o evento ao ocorrer o erro
			dispatchEvent(new ErrorEvent(LoadXML.LOAD_ERROR));
		}
		
		private function LoadIoError(e:IOErrorEvent):void 
		{
			//dispara o evento ao ocorrer o erro
			dispatchEvent(new IOErrorEvent(LoadXML.LOAD_IOERROR));
		}		

		private function LoadComplete(evt:Event):void
		{
			_xml = new XML(evt.currentTarget.data);			
			
			//dispara o evento ao ocorrer o erro
			dispatchEvent(new Event(LoadXML.LOAD_COMPLETE));			
		}		

		//SETTERS AND GETTERS
		public function get url():String { return _url; }

		public function set url(value:String):void 
		{
			_url = value;
		}

		public function get urlRequest():URLRequest { return _urlRequest; }

		public function set urlRequest(value:URLRequest):void 
		{
			_urlRequest = value;
		}

		public function get loader():URLLoader { return _loader; }

		public function set loader(value:URLLoader):void 
		{
			_loader = value;
		}
		
		public function get xml():XML { return _xml; }
		
		public function set xml(value:XML):void 
		{
			_xml = value;
		}
		 
	}
}