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
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class ViewLoader extends EventDispatcher
	{
		private var oDisplayLoader:DisplayLoadProgress;
		private var path:String;
		private var loader:Loader;
		private var fncCall:Function;
		private var loaderMC:MovieClip;
		private var stopAtFirst:Boolean;
		private var args:Array;
		private var context:LoaderContext = null;
						
		public function ViewLoader(path:String = null, carregar:Boolean = false , fncCall:Function = null , ...arguments)
		{
			this.args  = arguments;
			
			if (fncCall != null)
			{
				this.fncCall = fncCall;
			}
			
			this.loaderMC = null;
			this.stopAtFirst = false;
			
			if (path != null)
			{
				this.path = path;	
			}
			if (carregar)
			{
				Carregar();
			}			
		}
		
		
		//Function Call
		public function set FncCall(value:Function):void
		{
			this.fncCall = value;
		}
		
		//MC Loader
		public function set LoaderMC(value:MovieClip):void
		{
			this.loaderMC = value;
		}
		
		//Stop do MC Carregado
		public function set StopAtFirst(value:Boolean):void
		{
			this.stopAtFirst = value;
		}
		
		public function get Context():LoaderContext { return context; }
		
		public function set Context(value:LoaderContext):void 
		{
			context = value;
		}
		
		public function get Path():String { return path; }
		
		public function set Path(value:String):void 
		{
			path = value;
		}
		
		//Metodos		
		public function Carregar(path:String = null):void
		{
			oDisplayLoader          = new DisplayLoadProgress();
			oDisplayLoader.mcLoader = this.loaderMC;

			if (path != null)
			{
				this.path = path;
			}
			
			loader = new Loader();
			loader.load(new URLRequest (this.path) , Context);	
		
			loader.contentLoaderInfo.addEventListener(Event.OPEN,showDisplay);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,showProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOError);			
		}
		
		private function IOError(e:IOErrorEvent):void 
		{
			if (!hasEventListener(EvtClipLoader.IO_ERROR))
			{
				throw new Error("Arquivo não encontrado \""+ this.path + "\"");
			}
			else
			{
				dispatchEvent(new EvtClipLoader(EvtClipLoader.IO_ERROR));
			}

			if (oDisplayLoader.mcLoader != null)
			{
				oDisplayLoader.hideDisplay();
			}
		}
		
		private function showDisplay(event:Event):void
		{
			if (oDisplayLoader.mcLoader != null)
			{
				oDisplayLoader.showDisplay();
			}			
		}
		
		private function showProgress(event:ProgressEvent):void 
		{
			if (oDisplayLoader.mcLoader != null)
			{
				oDisplayLoader.showProgress (event.bytesLoaded, event.bytesTotal);
			}
		}

		private function completeProgress(event:Event):void 
		{
			var newArgs:Array = new Array();
			newArgs.push(loader);
			dispatchEvent(new EvtClipLoader(EvtClipLoader.LOAD));
			
			if (this.fncCall != null)
			{
				this.fncCall.apply(this , newArgs.concat(args));
			}

			if (oDisplayLoader.mcLoader != null)
			{
				oDisplayLoader.hideDisplay();
			}
		}
	}
}