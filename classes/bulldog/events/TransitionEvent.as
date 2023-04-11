package bulldog.events 
{
	import flash.events.Event;
	/**
	 * BullDOG 2.1.0  - Flash Extension Framework
	 * BullDOG 2010© - http://www.taxilabs.com.br
	 * @author Luiz Segundo
	 */
	public class TransitionEvent extends Event 
	{
		/** 
		 * Variável TRANSITION_IN_START:String. 
		 * 
		 * @default "tinstart"
		 */
		public static const TRANSITION_IN_START:String     = "tinstart";
		
		/** 
		 * Variável TRANSITION_IN_COMPLETE:String. 
		 * 
		 * @default "tincomplete"
		 */
		public static const TRANSITION_IN_COMPLETE:String  = "tincomplete";
		
		/** 
		 * Variável TRANSITION_OUT_START:String. 
		 * 
		 * @default "toutstart"
		 */
		public static const TRANSITION_OUT_START:String    = "toutstart";
		
		/** 
		 * Variável TRANSITION_OUT_COMPLETE:String. 
		 * 
		 * @default "toutcomplete"
		 */
		public static const TRANSITION_OUT_COMPLETE:String = "toutcomplete";
		
		/**
		 * Construtor TransitionEvent.
		 * 
		 * @param type:String Variável
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */ 
		public function TransitionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override clone.
		 * 
		 * @return Retorna TransitionEvent.
		 */
		public override function clone():Event 
		{ 
			return new TransitionEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * Método Public Override toString.
		 * 
		 * @return Retorna formatToString.
		 */	
		public override function toString():String 
		{ 
			return formatToString("TransitionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}