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

	public class IndexManager 
	{
		public static function BringToFront(target:MovieClip , container:MovieClip):void
		{
			container.setChildIndex(target , container.numChildren - 1);
		}
	}
}