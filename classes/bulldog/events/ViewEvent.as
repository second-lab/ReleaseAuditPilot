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

	public class ViewEvent extends Event 
	{
		/** 
		 * Variável INITIALIZED:String. 
		 * 
		 * @default "completeview"
		 */
		public static const INITIALIZED:String = "completeview";
		
		/** 
		 * Variável LOAD_DATAPROVIDER:String. 
		 * 
		 * @default "loaddataproviderview"
		 */
		public static const LOAD_DATAPROVIDER:String = "loaddataproviderview";
		
		/**
		 * Construtor ViewEvent.
		 * 
		 * @param type:String Variável
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */ 
		public function ViewEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/**
		 * Método Public Override clone.
		 * 
		 * @return Retorna ViewEvent.
		 */
		public override function clone():Event 
		{ 
			return new ViewEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override toString.
		 * 
		 * @return Retorna formatToString.
		 */	
		public override function toString():String 
		{ 
			return formatToString("ViewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}