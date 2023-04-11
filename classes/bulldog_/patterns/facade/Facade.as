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

package bulldog.patterns.facade
{
	import bulldog.debug.BullDogException;
	import projeto.mvc.*;
	
	
	public class Facade
	{
		/** 
		 * Variável instance:Facade. 
		 * 
		 * @default 
		 */
		private static var instance:Facade; 
		
		/** 
		 * Variável oController:SiteController. 
		 * 
		 * @default 
		 */
		private static var oController:SiteController;
		
		/** 
		 * Variável oView:SiteView. 
		 * 
		 * @default 
		 */
		private static var oView:SiteView;
		
		/** 
		 * Variável oModel:SiteModel. 
		 * 
		 * @default 
		 */
		private static var oModel:SiteModel;
		
		/**
		 * Construtor Facade.
		 */ 
		public function Facade() 
		{
			if (instance != null) throw BullDogException(BullDogException.SINGLETON);
			instance = this;
		}
		
		/**
		 * Método Protected Static Get Instance.
		 * 
		 * @return Classe Facade instance.
		 */
		protected static function get Instance():Facade 
		{
			if (instance == null) instance = new Facade();
			return instance;
		}
	
		/**
		 * Método Public Get OModel.
		 * 
		 * @return Classe SiteModel oModel.
		 */
		public function get OModel():SiteModel 
		{
			if (oModel == null) 
			{
				oModel = new SiteModel();
			}
			return oModel; 
		}
		
		/**
		 * Método Public Get OView.
		 * 
		 * @return Classe SiteView oView.
		 */
		public function get OView():SiteView 
		{ 
			if (oView == null) 
			{
				oView = new SiteView();
			}
			return oView; 
		}
		
		/**
		 * Método Public Get OController.
		 * 
		 * @return Classe SiteController oController.
		 */
		public function get OController():SiteController 
		{
			if (oController == null)
			{
				oController = new SiteController();
			}
			return oController; 
		}
	}
}