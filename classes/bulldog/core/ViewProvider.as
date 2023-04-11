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
	import bulldog.debug.BullDogException;
	import bulldog.enums.EEnviroment;
	import bulldog.events.ViewEvent;
	import bulldog.vo.VoInfoArea;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import utils.LoadXML;
	
	

	public class ViewProvider extends EventDispatcher
	{
		/** 
		 * Variável xmlListAreas:XMLList. 
		 * 
		 * @default  
		 */
		private var xmlListAreas:XMLList;
		
		/** 
		 * Variável xmlAreas:LoadXML. 
		 * 
		 * @default  
		 */
		private var xmlAreas:LoadXML;
		
		/** 
		 * Variável arrAreas:Array. 
		 * 
		 * @default new Array().
		 */
		private var arrAreas:Array = new Array();
		
		/** 
		 * Variável pathXMLAreas:String. 
		 * 
		 * @default "areas.xml" 
		 */
		private var pathXMLAreas:String = "areas.xml";
		
		/**
		 * Método Public URLConfigArea.
		 * 
		 * @return O path do config.
		 */
		public function URLConfigArea():String
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return "config/";
			}
			return "config/";
		}
		 
		/**
		 * Método Public Get ArrAreas.
		 * 
		 * @return Variável arrAreas.
		 */
		public function get ArrAreas():Array { return arrAreas; }
		
		/**
		 * Construtor ViewProvider.
		 */
		public function ViewProvider()
		{
			LoadViews();
		}
		
		/**
		 * Método Public GetInfoArea.
		 * 
		 * @param strArea:String Variável.
		 * 
		 * @return Variável arrAreas
		 */
		public function GetInfoArea(strArea:String):VoInfoArea
		{
			for (var i:int = 0; i < arrAreas.length; i++) 
			{
				if (arrAreas[i].Key == strArea)
				{
					return arrAreas[i];
				}
			}
			
			throw new BullDogException("Área especificada não encontrada." , BullDogException.AREA_PROVIDER);
		}
		
		/**
		 * Método Public GetInicialInfoArea.
		 * 
		 * @return arrAreas
		 */
		public function GetInicialInfoArea():VoInfoArea
		{
			for (var i:int = 0; i < arrAreas.length; i++) 
			{
				if (arrAreas[i].AreaInicial)
				{
					return arrAreas[i];
				}
			}
			throw new BullDogException("Nenhuma àrea inicial foi atribuida." , BullDogException.AREA_PROVIDER);
		}
		
		/**
		 * Método Protected LoadViews.
		 */
		public function LoadViews():void
		{
			xmlAreas = new LoadXML(URLConfigArea() + pathXMLAreas);
			xmlAreas.addEventListener(LoadXML.LOAD_COMPLETE, OnComplete);
			xmlAreas.addEventListener(LoadXML.LOAD_IOERROR, OnIOError);
		}
		
		/**
		 * Método Private OnComplete.
		 * 
		 * @param e:Event Evento
		 */
		private function OnComplete(e:Event):void
		{
			xmlListAreas = new XMLList(e.currentTarget.xml);			
			for each(var area:* in xmlListAreas.area)
			{
				var OInfoArea:VoInfoArea = new VoInfoArea(area.@key
														 ,area.@namespace
														 ,area.@property
														 ,area.@file
														 ,area.@descricao
														 ,area.@tag
														 ,Boolean(int(area.@newinstance))
														 ,Boolean(int(area.@tracker))
														 ,Boolean(int(area.@contextmenu))
														 ,Boolean(int(area.@areainicial))
														 ,area.@placeholder); 
				/**
				 * Valida se as áreas cadastradas no XML_AREAS estão declaradas na View
				 */
				try 
				{
					getDefinitionByName(OInfoArea.NameSpace);
				}
				catch (e:Error)
				{
					throw new BullDogException(e.message , BullDogException.AREA_PROVIDER);
				}

				arrAreas.push(OInfoArea);
			}
			
			dispatchEvent(new ViewEvent(ViewEvent.LOAD_DATAPROVIDER));
		}
		
		/**
		 * Método Private OnIOError.
		 * 
		 * @param e:Event Evento
		 */
		private function OnIOError(e:Event):void
		{
			throw new BullDogException("Arquivo com problemas ou não encontrado." , BullDogException.AREA_PROVIDER);
		}
	}
}