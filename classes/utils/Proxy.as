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
	public class Proxy {

	  public static function create(oTarget:Object, fFunction:Function , ...arguments):Function 
	  {
		var aParameters:Array = new Array();
		aParameters = arguments;
		
		var fProxy:Function = function():void
		{
			var aActualParameters:Array = arguments.concat(aParameters);
			fFunction.apply(oTarget, aActualParameters);
		};

		return fProxy;
	  }
	}
}