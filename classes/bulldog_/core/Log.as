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
	import projeto.SiteFacade;
	
	public class Log 
	{
		/**
		 * Método Static Public Print.
		 * 
		 * @param strLog:String Variável
		 */
		static public function Print(strLog:String):void
		{
			if(SiteFacade.Instance.OModel.GetValue("debug"))
				trace("bullDOG ► " + strLog);
		}	
	}
	
}