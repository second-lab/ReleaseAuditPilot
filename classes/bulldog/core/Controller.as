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
	import bulldog.events.ControllerEvent;
	import flash.events.EventDispatcher;

	public class Controller extends EventDispatcher
	{
		/**
		 * Construtor Controller.
		 */
		public function Controller()
		{
			InitializeController();
		}
		
		/**
		 * Método Public InitializeController.
		 */
		public function InitializeController():void
		{
			dispatchEvent(new ControllerEvent(ControllerEvent.INITIALIZED));
		}
	}
}