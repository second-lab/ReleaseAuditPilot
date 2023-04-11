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

package bulldog.core {
	import bulldog.api.IBasicView;
	import bulldog.debug.BullDogException;
	import bulldog.enums.EEnviroment;
	import bulldog.enums.EPh;
	import bulldog.events.NavigationEvent;
	import bulldog.events.TransitionEvent;
	import bulldog.templates.BasicView;
	import bulldog.vo.VoInfoArea;
	import bulldog.vo.VoPh;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;
	import projeto.SiteFacade;
	import utils.EvtClipLoader;
	import utils.ViewLoader;
	
	

	

	public class Navigation
	{
		private static var lastArea:VoInfoArea;
		
		private static var lastAboveArea:VoInfoArea;
		
		private static var removeAboveOnNavigation:Boolean;
		
		/** 
		 * Variável Static areaAtual:VoInfoArea. 
		 * 
		 * @default  
		 */
		private static var areaAtual:VoInfoArea;
		
		/** 
		 * Variável Static areaDest:VoInfoArea. 
		 * 
		 * @default  
		 */
		private static var areaDest:VoInfoArea;
		
		/** 
		 * Variável Static aboveAreaAtual:VoInfoArea. 
		 * 
		 * @default  
		 */
		private static var aboveAreaAtual:VoInfoArea;
		
		/** 
		 * Variável Static container:Object. 
		 * 
		 * @default  
		 */
		private static var container:Object;
		
		/** 
		 * Variável Static mcLoading:MovieClip. 
		 * 
		 * @default  
		 */
		private static var mcLoading:MovieClip;
		
		/** 
		 * Variável Static googleAnalytics:Boolean. 
		 * 
		 * @default false. 
		 */
		private static var googleAnalytics:Boolean = false;
		
		/** 
		 * Variável Static dispatcher:EventDispatcher. 
		 * 
		 * @default  
		 */
		private static var dispatcher:EventDispatcher;
		
		/** 
		 * Variável Static swfAddress:Boolean. 
		 * 
		 * @default false
		 */
		private static var swfAddress:Boolean = false;
		
		/** 
		 * Variável Static swfAddressSetTitle:Boolean. 
		 * 
		 * @default false
		 */
		private static var swfAddressSetTitle:Boolean = false;
		
		/** 
		 * Variável Static areaInicial:VoInfoArea. 
		 * 
		 * @default  
		 */
		private static var areaInicial:VoInfoArea;
		
		/** 
		 * Variável Static hasContextMenu:Boolean. 
		 * 
		 * @default false. 
		 */
		private static var hasContextMenu:Boolean = false;
		
		/** 
		 * Variável Static titleContextMenu:String. 
		 * 
		 * @default  
		 */
		private static var titleContextMenu:String;
		
		/** 
		 * Variável Static oContextMenuNavega:ContextMenuNavega. 
		 * 
		 * @default  
		 */
		private static var oContextMenuNavega:ContextMenuNavega;
		
		/** 
		 * Variável Static pathAreasSwf:String. 
		 * 
		 * @default  
		 */
		private static var pathAreasSwf:String;
		
		/** 
		 * Variável Static browserMainTitle:String. 
		 * 
		 * @default  
		 */
		private static var browserMainTitle:String;
		
		/** 
		 * Variável Static browserTitleSeparator:String. 
		 * 
		 * @default " - "
		 */
		private static var browserTitleSeparator:String = " - ";
		
		/** 
		 * Variável Static enabled:Boolean. 
		 * 
		 * @default true
		 */
		static private var enabled:Boolean = true;
		
		/** 
		 * Variável Static oVoPh:VoPh. 
		 * 
		 * @default  
		 */
		static private var oVoPh:VoPh;
		
		/** 
		 * Variável Static viewLoaded:DisplayObject. 
		 * 
		 * @default  
		 */
		static private var viewLoaded:DisplayObject;
		
		/** 
		 * Variável Static OLoader:Loader. 
		 * 
		 * @default  
		 */
		static private var OLoader:Loader;
		
		
		public static function get LastAboveArea():VoInfoArea
		{
			return lastAboveArea;
		}

		public static function set LastAboveArea(value:VoInfoArea):void
		{
			lastAboveArea = value;
		}

		public static function get RemoveAboveOnNavigation():Boolean
		{
			return removeAboveOnNavigation;
		}

		public static function set RemoveAboveOnNavigation(value:Boolean):void
		{
			removeAboveOnNavigation = value;
		}

		/** 
		 * Variável Static lastArea:VoInfoArea. 
		 * 
		 * @default  
		 */
		public static function get LastArea():VoInfoArea
		{
			return lastArea;
		}

		/**
		 * @private
		 */
		public static function set LastArea(value:VoInfoArea):void
		{
			lastArea = value;
		}

		/**
		 * Método Public Static Get AreaAtual.
		 * 
		 * @return areaAtual.
		 */
		public static function get AreaAtual():VoInfoArea { return areaAtual; }
		
		/**
		 * @private
		 */
		public static function set AreaAtual(value:VoInfoArea):void 
		{
			areaAtual = value;
		}
		
		/**
		 * Método Public Static Get AboveAreaAtual.
		 * 
		 * @return aboveAreaAtual.
		 */
		public static function get AboveAreaAtual():VoInfoArea { return aboveAreaAtual; }
		
		/**
		 * @private
		 */
		public static function set AboveAreaAtual(value:VoInfoArea):void 
		{
			aboveAreaAtual = value;
		}

		/**
		 * @private
		 */
		static public function set Container(value:Object):void 
		{
			container = value;
		}
		
		/**
		 * Método Static Public Get Container.
		 * 
		 * @return container.
		 */
		static public function get Container():Object { return container; }
		
		/**
		 * Método Static Public Get McLoading.
		 * 
		 * @return mcLoading.
		 */
		static public function get McLoading():MovieClip { return mcLoading; }
		
		/**
		 * @private
		 */
		static public function set McLoading(value:MovieClip):void 
		{
			mcLoading = value;
		}
		
		/**
		 * @private
		 */
		static public function set GoogleAnalytics(value:Boolean):void 
		{
			googleAnalytics = value;
		}
		
		/**
		 * Método Static Public Get Dispatcher.
		 * 
		 * @return dispatcher.
		 */
		static public function get Dispatcher():EventDispatcher 
		{ 
			if (dispatcher == null)
			{
				dispatcher = new EventDispatcher();
			}
			return dispatcher; 
		}
		
		/**
		 * @private
		 */
		static public function set SwfAddress(value:Boolean):void 
		{
			swfAddress = value;
		}
		
		/**
		 * @private
		 */
		static public function set SwfAddressSetTitle(value:Boolean):void 
		{
			swfAddressSetTitle = value;
		}
		
		/**
		 * @private
		 */
		static public function set AreaInicial(value:VoInfoArea):void 
		{
			areaInicial = value;
		}
		
		/**
		 * @private
		 */
		static public function set HasContextMenu(value:Boolean):void 
		{
			hasContextMenu = value;
		}
		
		/**
		 * Método Static Public Get OContextMenuNavega.
		 * 
		 * @return oContextMenuNavega.
		 */
		static public function get OContextMenuNavega():ContextMenuNavega { return oContextMenuNavega; }
		
		/**
		 * @private
		 */
		static public function set OContextMenuNavega(value:ContextMenuNavega):void 
		{
			oContextMenuNavega = value;
		}
		
		/**
		 * Método Static Public Get TitleContextMenu.
		 * 
		 * @return titleContextMenu.
		 */
		static public function get TitleContextMenu():String { return titleContextMenu; }
		
		/**
		 * @private
		 */
		static public function set TitleContextMenu(value:String):void 
		{
			titleContextMenu = value;
		}
		
		/**
		 * @private
		 */
		static public function set PathAreasSwf(value:String):void 
		{
			pathAreasSwf = value;
		}
		
		/**
		 * @private
		 */
		static public function set BrowserMainTitle(value:String):void 
		{
			browserMainTitle = value;
		}
		
		/**
		 * @private
		 */
		static public function set BrowserTitleSeparator(value:String):void 
		{
			browserTitleSeparator = value;
		}
		
		/**
		 * Método Static Public Get Enabled.
		 * 
		 * @return enabled.
		 */
		static public function get Enabled():Boolean { return enabled; }
		
		/**
		 * @private
		 */
		static public function set Enabled(value:Boolean):void 
		{
			enabled = value;
		}
		
		/**
		 * Método Static Public Get AreaDest.
		 * 
		 * @return areaDest.
		 */
		static public function get AreaDest():VoInfoArea { return areaDest; }
		
		/**
		 * @private
		 */
		static public function set AreaDest(value:VoInfoArea):void 
		{
			areaDest = value;
		}
				
		//
		/**
         * Registers an event listener
         * @param type Event type
         * @param listener Event listener
         */
        public static function AddEventListener(type:String, listener:Function):void 
		{
            Dispatcher.addEventListener(type, listener, false, 0, false);
        }

        /**
         * Removes an event listener.
		 * 
         * @param type Event type
         * @param listener Event listener
         */
        public static function RemoveEventListener(type:String, listener:Function):void 
		{
            Dispatcher.removeEventListener(type, listener, false);
        }

        /**
         * Dispatches an event to all the registered listeners. 
		 * 
         * @param event Event object
         */
        public static function DispatchEvent(event:NavigationEvent):Boolean 
		{
            return Dispatcher.dispatchEvent(event);
        }

        /**
         * Checks the existance of any listeners registered for a specific type of event. 
		 * 
         * @param event Event type
         */
        public static function HasEventListener(type:String):Boolean 
		{
            return Dispatcher.hasEventListener(type);
        }
		
		/**
		 * START NAVEGA
		 */
		public static function Init():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, HandleSWFAddress);
			
			if (hasContextMenu)
			{
				CreateContextMenu();
			}
		}
		
		/**
		 * Método Private Static HandleSWFAddress.
		 * 
		 * @param e:SWFAddressEvent Evento
		 */
		private static function HandleSWFAddress(e:SWFAddressEvent):void 
		{	
			var AreaHandle:VoInfoArea;
						
			if (e.value == '/')
			{
				if (areaInicial != null)
				{
					areaDest = areaInicial;
					CarregaArea();
				}
			}
			else
			{
				var titlestr:String = e.value.substr(0 , e.value.length-1);
				var ArrAreasTitle:Array = titlestr.split("/");
				ArrAreasTitle.shift();
				
				AreaHandle = SiteFacade.Instance.OView.GetInfoArea(ArrAreasTitle[0].split("/").join(""));
				areaDest   = AreaHandle; 
				CarregaArea();
			}
		}
		
		/**
		 * Método Private Static SetBrowserTitle.
		 * 
		 * @param strTitle:String Variável strTitle
		 */
		private static function SetBrowserTitle(strTitle:String):void
		{
			if (swfAddressSetTitle)
			{
				SWFAddress.setTitle(FormatTitle(strTitle));
			}
		}
		
		/**
		 * Método Private Static FormatTitle.
		 * 
		 * @param strTitle:String Variável
		 * 
		 * @return strTitle:String.
		 */
		private static function FormatTitle(strTitle:String):String
		{
			var tempTitle:String = "";
			if (browserMainTitle != null)
			{
				tempTitle += browserMainTitle;
			}
			if (strTitle != null && strTitle != "")
			{
				tempTitle += " " + browserTitleSeparator + " " + strTitle;
			}
			return tempTitle;
		}
		
		/**
		 * Método Public Static GoTo.
		 * 
		 * @param area:VoInfoArea Variável
		 */
		public static function GoTo(area:VoInfoArea):void
		{
			AreaDest = area;
			
			if(areaDest.PlaceHolder == "MAIN")
			{
				if (area == lastArea) return;
				
				if (areaAtual != null)
				{
					if(!BasicView(container[areaAtual.Property]).hasEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE))
					{
						BasicView(container[areaAtual.Property]).addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE , OnTransitionOutComplete);
						IBasicView(container[areaAtual.Property]).StartTransitionOut();
					}
				}
				else
				{
					Dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.PREPARE_AREA , areaDest));
					
					if (swfAddress && areaDest.File !="execute")
					{
						SWFAddress.setValue("/" + areaDest.Key  + "/");
					}
					else
					{
						if (swfAddress)
						{
							SWFAddress.setValue("/" + areaDest.Key + "/");
						}
						else
						{
							CarregaArea();
						}
					}
				}
				
				if (aboveAreaAtual != null && removeAboveOnNavigation)
				{
					BasicView(container[aboveAreaAtual.Property]).addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE , OnAboveWithMainTransitionOutComplete);
					IBasicView(container[aboveAreaAtual.Property]).StartTransitionOut();
				}
			}
			else if(areaDest.PlaceHolder == "ABOVE")
			{
				
				if (area == lastAboveArea) return;
				
				if (aboveAreaAtual != null)
				{
					BasicView(container[aboveAreaAtual.Property]).addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE , OnAboveTransitionOutComplete);
					IBasicView(container[aboveAreaAtual.Property]).StartTransitionOut();
				}
				else
				{
					Dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.PREPARE_AREA , areaDest));
					
					if (swfAddress && areaDest.File !="execute")
					{
						SWFAddress.setValue("/" + areaDest.Key  + "/");
					}
					else
					{
						if (swfAddress)
						{
							SWFAddress.setValue("/" + areaDest.Key + "/");
						}
						else
						{
							CarregaArea();
						}
					}
				}
			}			
		}
		
		/**
		 * Método Static Private OnAboveWithMainTransitionOutComplete.
		 * 
		 * @param e:TransitionEvent Evento
		 */
		static private function OnAboveWithMainTransitionOutComplete(e:TransitionEvent):void 
		{
			e.currentTarget.removeEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE , OnAboveWithMainTransitionOutComplete);
			aboveAreaAtual = null;
			lastAboveArea  = null;
		}
		
		/**
		 * Método Static Private OnAboveTransitionOutComplete.
		 * 
		 * @param e:TransitionEvent Evento
		 */
		static private function OnAboveTransitionOutComplete(e:TransitionEvent):void 
		{
			e.currentTarget.removeEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE , OnAboveTransitionOutComplete);
			aboveAreaAtual = null;
			GoTo(AreaDest);
		}
		
		/**
		 * Método Static Private OnTransitionOutComplete.
		 * 
		 * @param e:TransitionEvent Evento
		 */
		static private function OnTransitionOutComplete(e:TransitionEvent):void 
		{
			e.currentTarget.removeEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE , OnTransitionOutComplete);
			areaAtual = null;
			GoTo(AreaDest);
		}
		
		/**
		 * função de navegação de contéudo
		 * @param	areaDest
		 */
		private static function CarregaArea():void
		{
			SetBrowserTitle(areaDest.Descricao);
			
			Dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.START , areaDest));
			
			oVoPh = EPh[areaDest.PlaceHolder];
			
			if (areaDest.File != "execute")
			{
				var cl:ViewLoader = new ViewLoader(pathAreasSwf + areaDest.File , false , OnLoaderView);
				cl.addEventListener(EvtClipLoader.IO_ERROR , OnIOError);
				
				if (McLoading != null)
				{
					cl.LoaderMC = McLoading;
				}
				cl.Carregar();
			}
			else
			{
				RegisterClass();
			}
		}
		
		/**
		 * Método Static Private OnLoaderView.
		 * 
		 * @param pLoader:Loader Variável
		 */
		static private function OnLoaderView(pLoader:Loader):void
		{
			OLoader = pLoader;
			viewLoaded = pLoader.content;

			RegisterClass();
		}
	
		/**
		 * Método Static Private OnIOError.
		 * 
		 * @param e:EvtClipLoader Evento
		 */
		static private function OnIOError(e:EvtClipLoader):void
		{
			if (!Dispatcher.hasEventListener(EvtClipLoader.IO_ERROR))
			{
				throw new BullDogException("ARQUIVO \"" + e.currentTarget.Path + "\" NÃO ENCONTRADO.", BullDogException.FILE_AREA);
			}
			else 
			{
				Dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.IO_ERROR));
			}
		}
		
		/**
		 * Recebe o MovieClip container onde a área foi carregada na navegação atual. 
		 * Inicia a classe de acordo com o namespace do Enum da área da navegação atual.
		 */
		private static function RegisterClass():void
		{	
			if (areaDest.NewInstance)
			{
				container[areaDest.Property] = null;
			}
			
			if (container[areaDest.Property] == null)
			{
				var OClass:Class = getDefinitionByName(areaDest.NameSpace) as Class;
				var OIBasicView:IBasicView = new OClass() as IBasicView;
				OIBasicView.Address = SWFAddress.getValue();
				if (areaDest.File != "execute")
				{
					OIBasicView.LoaderInfo = OLoader;
					OIBasicView.InitClass(MovieClip(viewLoaded));
				}
				else
				{
					OIBasicView.InitObjects();
				}
				container[areaDest.Property] = OIBasicView;
			}
			else
			{
				container[areaDest.Property].Address = SWFAddress.getValue();
				
				if (areaDest.File != "execute")
				{
					container[areaDest.Property].LoaderInfo = OLoader;
					container[areaDest.Property].InitClass(MovieClip(viewLoaded));
				}
				else 
				{
					container[areaDest.Property].InitObjects();
				}
			}
			
			container[areaDest.Property].VOInfoArea = areaDest;
			
			if (areaDest.File != "execute") AddView();
			
			if(areaDest.PlaceHolder == "MAIN")
			{
				AreaAtual = areaDest;
				lastArea  = areaDest;
			}
			else if(areaDest.PlaceHolder == "ABOVE")
			{
				aboveAreaAtual = areaDest;
				lastAboveArea  = areaDest;
			}
			
			IBasicView(container[areaDest.Property]).StartTransitionIn();
			
			if(googleAnalytics)GoogleAnalyticsTracker(areaDest.Tag);
			
			//dispatcher de format area
			Dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.COMPLETE , areaDest));
		}
	
		/**
		 * Método Public Static GoogleAnalyticsTracker.
		 * 
		 * @param trackingString:String Variável
		 */
		public static function GoogleAnalyticsTracker(trackingString:String):void
		{
			if (EEnviroment.CurrentEnviroment() == EEnviroment.PROD)
			{
				ExternalInterface.call("dpc_pageview", trackingString);
			}
			else
			{
				Log.Print("pageview('" + trackingString + "')");
			}
		}
		
		//CONTEXT MENU
		/**
		 * Método Static Private CreateContextMenu.
		 */
		static private function CreateContextMenu():void
		{
			oContextMenuNavega = new ContextMenuNavega();
			
			if (TitleContextMenu != null)
			{
				OContextMenuNavega.ProjectTitle = TitleContextMenu;
			}
			
			for (var i:uint = 0; i < SiteFacade.Instance.OView.ArrAreas.length ; i++ )
			{
				var ItemArea:VoInfoArea = SiteFacade.Instance.OView.ArrAreas[i];
				if (ItemArea.ContextMenu)
				{
					oContextMenuNavega.AddItem(SiteFacade.Instance.OView.ArrAreas[i]);
				}
			}
		}
		
		/**
		 * 
		 * @param	KeyArea - key value of Area you want to remove
		 */
		public static function RemoveContextMenuItens(KeyArea:String):void
		{
			for (var i:uint = 0; i < SiteFacade.Instance.OView.ArrAreas.length ; i++ )
			{
				var ItemArea:VoInfoArea = SiteFacade.Instance.OView.ArrAreas[i];
				
				if (KeyArea == ItemArea.Key)
				{
					ItemArea.ContextMenu = false;
				}
			}
			CreateContextMenu();
		}
		
		/**
		 * 
		 * @param	KeyArea - key value of Area you want to remove
		 */
		public static function AddContextMenuItens(KeyArea:String):void
		{
			for (var i:uint = 0; i < SiteFacade.Instance.OView.ArrAreas.length ; i++ )
			{
				var ItemArea:VoInfoArea = SiteFacade.Instance.OView.ArrAreas[i];
				
				if (KeyArea == ItemArea.Key)
				{
					ItemArea.ContextMenu = true;
				}
			}
			CreateContextMenu();
		}
		
		/**
		 * Método Static Private AddView.
		 */		
		static private function AddView():void
		{
			while (oVoPh.Mc.numChildren > 0) 
			{
				oVoPh.Mc.removeChildAt(0);
			}
			
			var ToAdd:DisplayObject = DisplayObject(container[areaDest.Property].McMain);
			oVoPh.Mc.addChildAt(ToAdd, 0);
		}
		
		/**
		 * Método Public Static KillView.
		 * 
		 * @param pPh:MovieClip Variável
		 */
		public static function KillView(pPh:MovieClip):void
		{	
			while (pPh.numChildren > 0) 
			{
				pPh.removeChildAt(0);
			}
		}
	}
}