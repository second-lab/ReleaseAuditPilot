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
	
	public class EEnviroment 
	{
		/** 
		 * Variável PROD:String. 
		 * 
		 * @default "prod"
		 */
		public static const PROD:String   = "prod";
		
		/** 
		 * Variável LOCAL:String. 
		 * 
		 * @default "local"
		 */
		public static const LOCAL:String = "local";
		
		/** 
		 * Variável URLInfo:String. 
		 * 
		 * @default
		 */
		public static var URLInfo:String;
		
		/**
		 * Método Public Static CurrentEnviroment.
		 * 
		 * @return EEnviroment.PROD.
		 */
		public static function CurrentEnviroment():String
		{
			//if (URLInfo.indexOf("file:")!=-1)
			//{
				return EEnviroment.LOCAL;
			//}
			//return EEnviroment.PROD;
		}
	}
}