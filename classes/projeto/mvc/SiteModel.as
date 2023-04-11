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

package projeto.mvc {
	import bulldog.core.Model;
	import bulldog.enums.EEnviroment;
	import bulldog.events.ModelEvent;

	public class SiteModel extends Model
	{
		/**
		 * Método Public Get URLEnviroment.
		 * 
		 * @return EEnviroment.URLInfo.split("swf")[0].
		 */
		public function get URLEnviroment():String 
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return URLDesenvolvimento;
			}
			return EEnviroment.URLInfo.split("swf")[0];
		}

		/**
		 * Método Public Get URI.
		 * 
		 * @return URIFile.
		 */
		public function get URI():String
		{
			return URIFile;
		}

		/**
		 * Método Public Get URIFile.
		 * 
		 * @return GetValue("uri" , "connector").
		 */
		public function get URIFile():String
		{
			return GetValue("uri" , "connector");
		}

		/**
		 * Método Public Get URLImagem.
		 * 
		 * @return URLEnviroment + GetValue("urlimg" , "urls").
		 */
		public function get URLImagem():String
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return GetValue("urlimg" , "urls" ,"local");
			}
			return URLEnviroment + GetValue("urlimg" , "urls");
		}

		/**
		 * Método Public Get URLXml.
		 * 
		 * @return URLEnviroment + GetValue("urlxml" , "urls" , "web").
		 */
		public function get URLXml():String
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return GetValue("urlxml" , "urls" , "local");
			}
			return URLEnviroment + GetValue("urlxml" , "urls" , "web");
		}

		/**
		 * Método Public Get URLSwf.
		 * 
		 * @return URLEnviroment + GetValue("urlswf" , "urls" , "web").
		 */
		public function get URLSwf():String
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return GetValue("urlswf" , "urls" , "local");
			}
			return URLEnviroment + GetValue("urlswf" , "urls" , "web");
		}
		
		/**
		 * Método Public Get URLFlv.
		 * 
		 * @return URLEnviroment + GetValue("urlflv" , "urls" , "web").
		 */
		public function get URLFlv():String
		{
			if (EEnviroment.CurrentEnviroment() ==  EEnviroment.LOCAL)
			{
				return GetValue("urlflv" , "urls" , "local");
			}
			return URLEnviroment + GetValue("urlflv" , "urls" , "web");
		}
		
		/**
		 * Método Public Get SWFEstrutura.
		 * 
		 * @return GetValue("estrutura" , "assets").
		 */
		public function get SWFEstrutura():String 
		{ 
			return GetValue("estrutura" , "assets"); 
		}
		
		/**
		 * Método Public Get SWFLoading.
		 * 
		 * @return GetValue("loading" , "assets").
		 */
		public function get SWFLoading():String 
		{ 
			return GetValue("loading" , "assets"); 
		}
	
		/**
		 * Método Public Get URLDesenvolvimento.
		 * 
		 * @return GetValue("urldesenvolvimento" , "urls").
		 */
		public function get URLDesenvolvimento():String 
		{ 
			return GetValue("urldesenvolvimento" , "urls"); 
		}
	
		/**
		 * Construtor SiteModel.
		 */
		public function SiteModel()
		{
			super();
			addEventListener(ModelEvent.SETUP_COMPLETE , InitializeSiteModel);	
		}

		/**
		 * Método Public InitializeSiteController.
		 * 
		 * @param e:ModelEvent Evento
		 */
		public function InitializeSiteModel(e:ModelEvent):void
		{
			dispatchEvent(new ModelEvent(ModelEvent.INITIALIZED));
		}
	}
}