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
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	
	public class ClipLoader extends EventDispatcher
	{
		private var oDisplayLoader:DisplayLoadProgress;
		private var target:MovieClip;
		private var path:String;
		private var loader:Loader;
		private var alphaStart:Number;
		private var alphaEnd:Number;
		private var timerAlpha:Number;
		private var fncCall:Function;
		private var loaderMC:MovieClip;
		private var stopAtFirst:Boolean;
		private var args:Array;
		private var context:LoaderContext = null;
		private var removeChildFirst:Boolean = false;
				
		public function ClipLoader(target:MovieClip = null, path:String = null, carregar:Boolean = false , fncCall:Function = null , ...arguments)
		{
			//Seta dados default			
			this.alphaStart = 1;
			this.alphaEnd = 1;
			this.timerAlpha = 2;
			this.args  = arguments;
			
			if (fncCall != null)
			{
				this.fncCall = fncCall;
			}
			
			this.loaderMC = null;
			this.stopAtFirst = false;
			
			//Obter dados.
			if (target != null)
			{				
				this.target = target;
			}
			
			if (path != null)
			{
				this.path = path;	
			}
			if (carregar)
			{
				Carregar();
			}			
		}
		
		//Propriedades
		
		// Alpha Inicial
		public function set AlphaStart(value:Number):void
		{
			this.alphaStart = value;
		}
		
		//Alpha Final
		public function set AlphaEnd(value:Number):void
		{
			this.alphaEnd = value;
		}
		
		//Set Timer Tween
		public function set TimerAlpha(value:Number):void
		{
			this.timerAlpha = value;
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
		
		public function set RemoveChildFirst(value:Boolean):void 
		{
			removeChildFirst = value;
		}
		
		//Metodos		
		public function Carregar(target:MovieClip = null, path:String = null):void
		{
			oDisplayLoader          = new DisplayLoadProgress();
			oDisplayLoader.mcLoader = this.loaderMC;

			if (target != null)
			{
				this.target = target;
			}
			
			if (path != null)
			{
				this.path = path;
			}
			
			if (this.target.numChildren > 0 && removeChildFirst)
			{
				dispatchEvent(new EvtClipLoader(EvtClipLoader.UNLOAD));
				this.target.removeChildAt(0);
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
			var externalMovie:DisplayObject = loader.content;
			var newArgs:Array = new Array();
			newArgs.push(externalMovie);
			
			if (this.target.numChildren > 0)
			{
				dispatchEvent(new EvtClipLoader(EvtClipLoader.UNLOAD));
				this.target.removeChildAt(0);
			}
			
			this.target.addChild(externalMovie);
			
			dispatchEvent(new EvtClipLoader(EvtClipLoader.LOAD));
			
			if (this.fncCall != null)
			{
				this.fncCall.apply(this , newArgs.concat(args));
			}

			if (oDisplayLoader.mcLoader != null)
			{
				oDisplayLoader.hideDisplay();
			}
				
			if (externalMovie is MovieClip)
			{
				if (this.stopAtFirst)
				{
					MovieClip(externalMovie).stop();
				}				
			}				
				
			if (this.alphaEnd == this.alphaStart)
			{
				this.target.alpha = alphaEnd;
			}else
			{
				this.target.alpha = this.alphaStart;
				Tweener.addTween(this.target , { alpha:this.alphaEnd , time:this.timerAlpha , transition:"EaseOutExpo" } );
			}
		}
		
	}
	
}