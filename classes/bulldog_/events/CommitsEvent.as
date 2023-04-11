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
	
	public class CommitsEvent extends Event 
	{
		/** 
		 * Variável INITIALIZED:String. 
		 * 
		 * @default "completeapp"
		 */
		public static const INITIALIZED:String = "completeapp";
		
		/** 
		 * Variável SETUP_COMPLETE:String. 
		 * 
		 * @default "setuopcompleteapp"
		 */
		public static const SETUP_COMPLETE:String = "setuopcompleteapp";
		
		/** 
		 * Variável LOAD_DATAPROVIDER:String. 
		 * 
		 * @default "loaddataprovider"
		 */
		public static const LOAD_DATAPROVIDER:String = "loaddataprovider";
		
		public static const COMPLETE : String = "complete";
		
		public var HashLabel:String;
		public var HashData:Object;
		
		
		/**
		 * Construtor ModelEvent
		 * 
		 * @param type:String.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function CommitsEvent(type:String, hash_label:String = null, hash_data:Object =null ,bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			
			HashLabel = hash_label;
			HashData = hash_data;
			super(type, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override clone.
		 * 
		 * @return Retorna ModelEvent.
		 */	
		public override function clone():Event 
		{ 
			return new CommitsEvent(type,HashLabel, HashData, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override toString.
		 * 
		 * @return Retorna formatToString.
		 */	
		public override function toString():String 
		{ 
			return formatToString("CommitsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}