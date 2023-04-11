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
  
package bulldog.api 
{
	import flash.display.MovieClip;
	
	public interface IView 
	{
		/**
		 * Método Get PhMiolo
		 */
		function get PhMiolo():MovieClip;
		
		/**
		 * @private
		 */
		function set PhMiolo(value:MovieClip):void;
		
		/**
		 * Método Get PhAbove
		 */
		function get PhAbove():MovieClip;
		
		/**
		 * @private
		 */
		function set PhAbove(value:MovieClip):void;
		
		/**
		 * Método Get McMain
		 */
		function get McMain():MovieClip;
		
		/**
		 * @private
		 */
		function set McMain(value:MovieClip):void;
		
	}
	
}