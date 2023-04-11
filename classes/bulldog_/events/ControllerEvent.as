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

package bulldog.events 
{
	import flash.events.Event;
	
	public class ControllerEvent extends Event 
	{
		/** 
		 * Variável INITIALIZED:String. 
		 * 
		 * @default "completecontroller"
		 */
		public static const INITIALIZED:String = "completecontroller";
		
		/** 
		 * Variável LOAD_DATAPROVIDER:String. 
		 * 
		 * @default "loaddataprovidercontroller"
		 */
		public static const LOAD_DATAPROVIDER:String = "loaddataprovidercontroller";
		
		/**
		 * Construtor ControllerEvent.
		 * 
		 * @param type:String Variável
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function ControllerEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override clone.
		 * 
		 * @return Retorna ControllerEvent.
		 */	
		public override function clone():Event 
		{ 
			return new ControllerEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override toString.
		 * 
		 * @return Retorna formatToString.
		 */	
		public override function toString():String 
		{ 
			return formatToString("ControllerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}