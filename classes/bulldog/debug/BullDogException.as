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

package bulldog.debug 
{
	public class BullDogException extends Error
	{
		/** 
		 * Variável CONFIG_PROVIDER:String. 
		 * 
		 * @default "FLASH.CONFIG"
		 */
		public static const CONFIG_PROVIDER:String = "FLASH.CONFIG";
		
		/** 
		 * Variável AREA_PROVIDER:String. 
		 * 
		 * @default "ÁREAS XML"
		 */
		public static const AREA_PROVIDER:String   = "ÁREAS XML";
		
		/** 
		 * Variável FILE_ESTRUCTURE:String. 
		 * 
		 * @default "ARQUIVO DE ESTRUTURA"
		 */
		public static const FILE_ESTRUCTURE:String = "ARQUIVO DE ESTRUTURA";
		
		/** 
		 * Variável FILE_AREA:String. 
		 * 
		 * @default "ARQUIVO DE ÁREA"
		 */
		public static const FILE_AREA:String       = "ARQUIVO DE ÁREA";
		
		/** 
		 * Variável SINGLETON:String. 
		 * 
		 * @default "YOU CAN NOT INITIALIZE THIS CLASS, IT'S A SINGLETON INSTANCE"
		 */
		public static const SINGLETON:String       = "YOU CAN NOT INITIALIZE THIS CLASS, IT'S A SINGLETON INSTANCE";
		
		/**
		 * Construtor BullDogException.
		 * 
		 * @param strErro:String Variável
		 * @param type:String
		 * @param id:int
		 */
		public function BullDogException(strErro:String , type:String , id:int=0) 
		{
			super("bullDOG > Exception: " + type + ": " + strErro , id);
		}
	}
}