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
	import bulldog.vo.VoInfoArea;
	import flash.events.Event;
	
	public class NavigationEvent extends Event 
	{
		/** 
		 * Variável Area:VoInfoArea. 
		 * 
		 * @default 
		 */
		public var Area:VoInfoArea;
		
		/** 
		 * Variável START:String. 
		 * 
		 * @default "startnavega"
		 */
		public static const START:String     = "startnavega";
		
		/** 
		 * Variável PREPARE_AREA:String. 
		 * 
		 * @default "preparenavega"
		 */
		public static const PREPARE_AREA:String = "preparenavega";
		
		/** 
		 * Variável LOADING:String. 
		 * 
		 * @default "loadingnavega"
		 */
		public static const LOADING:String   = "loadingnavega";
		
		/** 
		 * Variável COMPLETE:String. 
		 * 
		 * @default "completenavega"
		 */
		public static const COMPLETE:String  = "completenavega";
		
		/** 
		 * Variável IO_ERROR:String. 
		 * 
		 * @default "ioerrornavega"
		 */
		public static const IO_ERROR:String  = "ioerrornavega";
		
		/** 
		 * Variável UNLOAD:String. 
		 * 
		 * @default "unloadnavega"
		 */
		public static const UNLOAD:String    = "unloadnavega";
		
		/**
		 * Construtor NavigationEvent.
		 * 
		 * @param type:String Variável
		 * @param pArea:VoInfoArea
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */ 
		public function NavigationEvent(type:String, pArea:VoInfoArea = null , bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			Area = pArea;
		} 
		
		/**
		 * Método Public Override clone.
		 * 
		 * @return Retorna NavigationEvent.
		 */
		public override function clone():Event
		{ 
			return new NavigationEvent(type, Area , bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override toString.
		 * 
		 * @return Retorna formatToString.
		 */	
		public override function toString():String 
		{ 
			return formatToString("NavigationEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}