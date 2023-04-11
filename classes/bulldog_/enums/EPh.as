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

package bulldog.enums 
{
	import bulldog.vo.VoPh;
	import projeto.SiteFacade;
	
	
	public class EPh
	{
		/** 
		 * Variável MAIN:VoPh. 
		 * 
		 * @default new VoPh(0 , SiteFacade.Instance.OView.PhMiolo)
		 */
		public static const MAIN:VoPh  = new VoPh(0 , SiteFacade.Instance.OView.PhMiolo);
		
		/** 
		 * Variável ABOVE:VoPh. 
		 * 
		 * @default new VoPh(1 , SiteFacade.Instance.OView.PhAbove)
		 */
		//public static const ABOVE:VoPh = new VoPh(1 , SiteFacade.Instance.OView.PhAbove);
	}
}