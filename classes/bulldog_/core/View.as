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

package bulldog.core 
{
	import bulldog.api.IView;
	import bulldog.debug.BullDogException;
	import bulldog.events.ViewEvent;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import projeto.SiteFacade;
	import utils.ClipLoader;
	import utils.EvtClipLoader;
	import utils.ViewLoader;
	
	
	
	
	public class View extends ViewProvider implements IView
	{
		/** 0         
		 * Variável mcMain:MovieClip. 
  		 * 
		 * @default  
		 */
		private var mcMain:MovieClip;
		
		/** 
		 * Variável phAbove:MovieClip. 
		 * 
		 * @default  
		 */
		private var phAbove:MovieClip;
		
		/** 
		 * Variável phMiolo:MovieClip. 
		 * 
		 * @default  
		 */
		private var phMiolo:MovieClip;
		 
		/** 
		 * Variável phMiolo:MovieClip. 
		 * 
		 * @default  
		 */
		private var mcLoading:MovieClip;
		
		/** 
		 * Variável oLoader:Loader. 
		 * 
		 * @default  
		 */
		private var oLoader:Loader;
		
		/**
		 * Método Public Get McMain.
		 * 
		 * @return mcMain.
		 */
		public function get McMain():MovieClip
		{ 
			if (mcMain == null)
			{
				mcMain = new MovieClip();
				SiteFacade.Instance.OModel.OStage.addChild(mcMain);
			}
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
		 * Método Public Get PhAbove.
		 * 
		 * @return phAbove.
		 */
		public function get PhAbove():MovieClip
		{
			if (phAbove == null)
			{
				phAbove = new MovieClip();
				phAbove.name = "phAbove";
				mcMain.addChildAt(phAbove , mcMain.numChildren);
			}
			return phAbove; 
		}
		
		/**
		 * @private
		 */
		public function set PhAbove(value:MovieClip):void
		{
			phAbove = value;
		}
		
		/**
		 * Método Public Get PhMiolo.
		 * 
		 * @return phMiolo.
		 */
		public function get PhMiolo():MovieClip
		{ 
			if (phMiolo == null)
			{
				phMiolo = new MovieClip();
				phMiolo.name = "phMiolo";
				mcMain.addChildAt(phMiolo , mcMain.numChildren);
			}
			return phMiolo; 
		}
		
		/**
		 * @private
		 */
		public function set PhMiolo(value:MovieClip):void 
		{
			phMiolo = value;
		}
		
		/**
		 * Método Public Get McLoading.
		 * 
		 * @return mcLoading.
		 */
		public function get McLoading():MovieClip { return mcLoading; }
		
		/**
		 * @private
		 */
		public function set McLoading(value:MovieClip):void 
		{
			mcLoading = value;
		}
		
		/**
		 * Método Public Get OLoader.
		 * 
		 * @return oLoader.
		 */
		public function get OLoader():Loader { return oLoader; }
		
		/**
		 * @private
		 */
		public function set OLoader(value:Loader):void 
		{
			oLoader = value;
		}
		
		/**
		 * Construtor View.
		 */
		public function View()
		{
			super();
			addEventListener(ViewEvent.LOAD_DATAPROVIDER , LoadView);
		}
		
		/**
		 * This method should be override
		 */
		protected function InitializeView():void
		{
			dispatchEvent(new ViewEvent(ViewEvent.INITIALIZED));
		}
		
		/**
		 * This method should be override
		 */
		protected function LoadView(e:ViewEvent):void
		{
			CarregaLoading();
		}
		
		/**
		 * This method should be override
		 */
		protected function CarregaLoading():void
		{
			var lc:ClipLoader = new ClipLoader(McMain , SiteFacade.Instance.OModel.URLSwf + SiteFacade.Instance.OModel.SWFLoading , false , CarregaEstrutura);
			lc.addEventListener(EvtClipLoader.IO_ERROR, OnIOError );
			lc.Carregar();
		}
		
		private function OnIOError(e:EvtClipLoader):void 
		{
			throw new BullDogException("ARQUVIO DE LOADING \""+SiteFacade.Instance.OModel.SWFLoading +"\" NÃO FOI ENCONTRADO." , BullDogException.FILE_ESTRUCTURE);
		}
		
		/**
		 * This method should be override
		 */
		protected function CarregaEstrutura(pMcLoading:MovieClip = null):void
		{
			var lc:ViewLoader = new ViewLoader(SiteFacade.Instance.OModel.URLSwf + SiteFacade.Instance.OModel.SWFEstrutura , false , StartEstrutura);
			McLoading  = MovieClip(McMain.addChildAt(pMcLoading.mcLoad, McMain.numChildren));
			lc.LoaderMC = mcLoading;
			lc.Carregar();
		}
		
		/**
		 * This method should be override
		 */
		protected function StartEstrutura(loader:Loader):void
		{
			oLoader = loader;
			var externalMovie:DisplayObject = oLoader.content;
			InitClass(MovieClip(McMain.addChild(externalMovie)));
		}
		
		/**
		 * This method should be override
		 */
		protected function InitClass(mc:MovieClip):void
		{
			
			if (mc.mcMain != null)
			{
				McMain = mc.mcMain;
			}
			else
			{
				McMain = mc;
			}
			
			//Cria os PHs e add no McMain
			
			
			McMain.addChildAt(McLoading , McMain.numChildren);
			PhMiolo;
			PhAbove;
			InitializeView();
		}
		
		/**
		 * Método Protected GetClassLibrary.
		 * 
		 * @param linkage:String Variável
		 * 
		 * @return Class
		 */
		public function GetClassLibrary(linkage:String):Class
		{
			return OLoader.contentLoaderInfo.applicationDomain.getDefinition(linkage) as Class;
		}
		
		/**
		 * Método Protected GetDisplayObjectLibrary.
		 * 
		 * @param linkage:String Variável
		 * 
		 * @return DisplayObject.
		 */
		public function GetDisplayObjectLibrary(linkage:String):DisplayObject
		{
			var oClass:Class = OLoader.contentLoaderInfo.applicationDomain.getDefinition(linkage) as Class;
			return new oClass() as DisplayObject;
		}
	}
	
}