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

package utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EvtClipLoader extends Event 
	{
		public static const LOAD:String = "cliploaderload";
		public static const UNLOAD:String = "cliploaderunload";
		public static const IO_ERROR:String = "cliploaderioerror";
		
		public var McLoaded:MovieClip;
		
		public function EvtClipLoader(type:String, pMcLoaded:MovieClip = null , bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			McLoaded = pMcLoaded;
		} 
		
		public override function clone():Event 
		{ 
			return new EvtClipLoader(type, McLoaded ,bubbles, cancelable);
		} 
		
		public override function toString():String
		{ 
			return formatToString("EvtClipLoader", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}