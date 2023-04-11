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
	import bulldog.vo.VoInfoArea;
	import flash.display.Loader;
	import flash.display.MovieClip;
	

	public interface IBasicView
	{
		/**
		 * Método Get Address
		 */
		function get Address():String;
		
		/**
		 * @private
		 */
		function set Address(value:String):void;
		
		/**
		 * Método Get McMain
		 */
		function get McMain():MovieClip;
		
		/**
		 * @private
		 */
		function set McMain(value:MovieClip):void;
		
		/**
		 * Método Get LoaderInfo
		 */
		function get LoaderInfo():Loader;
		
		/**
		 * @private
		 */
		function set LoaderInfo(value:Loader):void;
		
		/**
		 * Método Get VOInfoArea
		 */
		function get VOInfoArea():VoInfoArea;
		
		/**
		 * @private
		 */
		function set VOInfoArea(value:VoInfoArea):void;
		
		/**
		 * Método InitClass.
		 *
		 * @param mc:MovieClip Variável.
		 */
		function InitClass(mc:MovieClip):void;
		
		/**
		 * Método InitObjects.
		 */
		function InitObjects():void;
		
		/**
		 * Método KillView.
		 */
		function KillView():void;
		
		/**
		 * Método StartTransitionIn.
		 */
		function StartTransitionIn():void;
		
		/**
		 * Método FinishTransitionIn.
		 */
		function FinishTransitionIn():void;
		
		/**
		 * Método StartTransitionOut.
		 */
		function StartTransitionOut():void;
		
		/**
		 * Método FinishTransitionOut.
		 */
		function FinishTransitionOut():void;
	}
}