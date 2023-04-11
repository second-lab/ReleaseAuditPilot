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

package bulldog.templates {
	import bulldog.events.TransitionEvent;
	import bulldog.vo.VoInfoArea;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	

	public class BasicView extends EventDispatcher
	{
		/** 
		 * Variável mcMain:MovieClip. 
		 * 
		 * @default 
		 */
		protected var mcMain:MovieClip;
		
		/** 
		 * Variável loaderInfo:Loader. 
		 * 
		 * @default 
		 */
		protected var loaderInfo:Loader;
		
		/** 
		 * Variável address:String. 
		 * 
		 * @default 
		 */
		protected var address:String;
		
		/** 
		 * Variável vOInfoArea:VoInfoArea. 
		 * 
		 * @default 
		 */
		protected var vOInfoArea:VoInfoArea;
		
		/**
		 * Método Public Get McMain.
		 * 
		 * @return Classe MovieClip mcMain.
		 */
		public function get McMain():MovieClip 
		{ 
			return mcMain; 
		}
		
		/**
		 * @private
		 */
		public function set McMain(value:MovieClip):void 
		{
			mcMain = value;
		}	
		
		/**
		 * Método Public Get LoaderInfo.
		 * 
		 * @return Classe Loader loaderInfo.
		 */
		public function get LoaderInfo():Loader { return loaderInfo; }
		
		/**
		 * @private
		 */
		public function set LoaderInfo(value:Loader):void 
		{
			loaderInfo = value;
		}
		
		/**
		 * Método Public Get Address.
		 * 
		 * @return Variável String address.
		 */
		public function get Address():String { return address; }
		
		/**
		 * @private
		 */
		public function set Address(value:String):void 
		{
			address = value;
		}
		
		/**
		 * Método Public Get VOInfoArea.
		 * 
		 * @return Classe VoInfoArea vOInfoArea.
		 */
		public function get VOInfoArea():VoInfoArea { return vOInfoArea; }
		
		/**
		 * @private
		 */
		public function set VOInfoArea(value:VoInfoArea):void 
		{
			vOInfoArea = value;
		}
		
		/**
		 * Método Public InitClass.
		 * 
		 * @param mc:MovieClip Variável.
		 */
		public function InitClass(mc:MovieClip):void
		{
			if (mc.mcMain != null)
			{
				McMain = mc.mcMain;
			}
			else
			{
				McMain = mc;
			}
			InitObjects();
		}
		
		/**
		 * This method should be override
		 */
		public function InitObjects():void
		{
			StartTransitionIn();
		}
		
		/**
		 * This method should be override
		 */
		public function KillView():void 
		{
			if (McMain == null) return; 
			if (McMain.parent is MovieClip)
			{
				MovieClip(McMain.parent).removeChild(mcMain);
			}
		}
		
		/**
		 * This method should be override
		 */
		public function StartTransitionIn():void 
		{
			FinishTransitionIn();
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_START));
		}
		
		/**
		 * This method should be override
		 */
		public function FinishTransitionIn():void{dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_COMPLETE));}
		
		/**
		 * This method should be override
		 */
		public function StartTransitionOut():void
		{
			FinishTransitionOut();
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_START));
		}
		
		/**
		 * This method should be override
		 */
		public function FinishTransitionOut():void 
		{ 
			KillView();
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_COMPLETE)); 
		}
		
		/**
		 * Método Protected GetClassLibrary.
		 * 
		 * @param linkage:String Variável.
		 * 
		 * @return Class
		 */
		protected function GetClassLibrary(linkage:String):Class
		{
			return loaderInfo.contentLoaderInfo.applicationDomain.getDefinition(linkage) as Class;
		}
		
		/**
		 * Método Protected GetClassLibrary.
		 * 
		 * @param linkage:String Variável.
		 * 
		 * @return DisplayObject
		 */
		protected function GetDisplayObjectLibrary(linkage:String):DisplayObject
		{
			var oClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition(linkage) as Class;
			return new oClass() as DisplayObject;
		}
	}
}