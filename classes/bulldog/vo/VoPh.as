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

package bulldog.vo 
{
	import flash.display.MovieClip;
	
	public class VoPh 
	{
		/** 
		 * Variável id:uint. 
		 * 
		 * @default 
		 */
		private var id:uint;
		
		/** 
		 * Variável mc:MovieClip. 
		 * 
		 * @default 
		 */
		private var mc:MovieClip;
		
		/**
		 * Construtor VoPh.
		 * 
		 * @param pId:uint Variável.
		 * @param pMc:MovieClip Variável.
		 */ 
		public function VoPh(pId:uint , pMc:MovieClip) 
		{
			id = pId;
			mc = pMc;
		}
		
		/**
		 * Método Public Get Id.
		 * 
		 * @return Variável id.
		 */
		public function get Id():uint { return id; }
		
		/**
		 * Método Public Get Mc.
		 * 
		 * @return Classe MovieClip mc.
		 */
		public function get Mc():MovieClip { return mc; }
		
	}
	
}