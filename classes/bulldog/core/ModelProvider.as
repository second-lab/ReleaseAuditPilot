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
	import bulldog.events.ModelEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import utils.LoadXML;
	
	
	
	public class ModelProvider extends EventDispatcher
	{
		/** 
		 * Variável xmlLoad:LoadXML.
		 * 
		 * @default
		 */
		private var xmlLoad:LoadXML;
		
		/** 
		 * Variável xmlConfig:XMLList.
		 *
		 * @default
		 */
		protected var xmlConfig:XMLList;
		
		/**
		 * Método Public URLConfig.
		 * 
		 * @return O path do config.
		 */
		public function URLConfig():String
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return "config/";
			}
			return "config/";
		}
		
		/**
		 * Método Public InitializeModelProvider.
		 */
		public function InitializeModelProvider():void
		{
			LoadAppConfig();
		}
		
		/**
		 * Método Private LoadAppConfig.
		 */
		private function LoadAppConfig():void
		{
			xmlLoad = new LoadXML(URLConfig() + "appflash.xml");
			xmlLoad.addEventListener(LoadXML.LOAD_COMPLETE, OnComplete);
			xmlLoad.addEventListener(LoadXML.LOAD_IOERROR, OnIOError);
		}
		
		/**
		 * Método Private OnIOError.
		 * 
		 * @param e:Event Evento
		 */
		private function OnIOError(e:Event):void 
		{
			throw new BullDogException("Arquivo de com problemas ou não encontrado" , BullDogException.CONFIG_PROVIDER);
		}
		
		/**
		 * Método Private OnComplete.
		 * 
		 * @param e:Event Evento
		 */
		private function OnComplete(e:Event):void
		{
			xmlConfig = new XMLList(e.currentTarget.xml);
			dispatchEvent(new ModelEvent(ModelEvent.LOAD_DATAPROVIDER, xmlConfig));
		}
	}
}