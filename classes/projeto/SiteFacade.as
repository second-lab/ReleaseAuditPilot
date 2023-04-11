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

package projeto
{
	import bulldog.patterns.facade.Facade;
	
	public class SiteFacade extends Facade
	{
		private static var instance:SiteFacade; 
			
		public function SiteFacade() 
		{
			super();
			if (instance != null) throw Error("");
			instance = this;
		}
		
		public static function get Instance():SiteFacade 
		{
			if (instance == null) instance = new SiteFacade();
			return instance;
		}
	}
}