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
	public class VoInfoArea 
	{		
		/** 
		 * Variável key:String. 
		 * 
		 * @default 
		 */
		private var key:String;
		
		/** 
		 * Variável nameSpace:String. 
		 * 
		 * @default 
		 */
		private var nameSpace:String;
		
		/** 
		 * Variável property:String. 
		 * 
		 * @default 
		 */
		private var property:String;
		
		/** 
		 * Variável file:String. 
		 * 
		 * @default 
		 */
		private var file:String;
		
		/** 
		 * Variável descricao:String. 
		 * 
		 * @default 
		 */
		private var descricao:String;
		
		/** 
		 * Variável tag:String. 
		 * 
		 * @default 
		 */
		private var tag:String;
		
		/** 
		 * Variável newInstance:Boolean. 
		 * 
		 * @default 
		 */
		private var newInstance:Boolean; 
		
		/** 
		 * Variável tracker:Boolean. 
		 * 
		 * @default 
		 */
		private var tracker:Boolean;
		
		/** 
		 * Variável contextMenu:Boolean. 
		 * 
		 * @default 
		 */
		private var contextMenu:Boolean;
		
		/** 
		 * Variável areaInicial:Boolean. 
		 * 
		 * @default 
		 */
		private var areaInicial:Boolean;
		
		/** 
		 * Variável placeHolder:String. 
		 * 
		 * @default 
		 */
		private var placeHolder:String;
				
		/**
		 * Construtor VoInfoArea.
		 * 
		 * @param	pKey          = Chave unicia de identificação
		 * @param	pNameSpace    = Endereço fisico da classe.
		 * @param	pProperty     = Nome da propriedade que terá a instancia do objeto.
		 * @param	pDescricao    = Nome descritivo da área.
		 * @param	pTag          = String a ser passada para SEO
		 * @param	pFile         = Arquivo da área a ser carregado.
		 * @param	pNewInstance  = Indica se a classe será uma nova instancia a cada navegação.
		 * @param	pTracker      = Indica se a área terá tracker no Google Analytics.
		 * @param	pContextMenu  = Indica se a área terá acesso via contextmenu.
		 */
		public function VoInfoArea(pKey:String , pNameSpace:String , pProperty:String , pFile:String , pDescricao:String, pTag:String , pNewInstance:Boolean , pTracker:Boolean , pContextMenu:Boolean , pAreaInicial:Boolean , pPh:String)
		{
			key         = pKey;
			nameSpace   = pNameSpace;
			property    = pProperty;
			file        = pFile;
			descricao   = pDescricao;
			newInstance = pNewInstance;
			tracker     = pTracker;
			contextMenu = pContextMenu;
			areaInicial = pAreaInicial;
			placeHolder = pPh;
			tag         = pTag;
		}
		
		/**
		 * Método Public Get Key.
		 * 
		 * @return Variável key.
		 */
		public function get Key():String { return key; }
		
		/**
		 * Método Public Get NameSpace.
		 * 
		 * @return Variável nameSpace.
		 */
		public function get NameSpace():String { return nameSpace; }
		
		/**
		 * Método Public Get File.
		 * 
		 * @return Variável file.
		 */
		public function get File():String { return file; }
		
		/**
		 * Método Public Get Property.
		 * 
		 * @return Variável property.
		 */
		public function get Property():String {return property;}
		
		/**
		 * Método Public Get NewInstance.
		 * 
		 * @return Variável newInstance.
		 */
		public function get NewInstance():Boolean { return newInstance; }
		
		/**
		 * Método Public Get Tracker.
		 * 
		 * @return Variável tracker.
		 */
		public function get Tracker():Boolean { return tracker; }
		
		/**
		 * Método Public Get Descricao.
		 * 
		 * @return Variável descricao.
		 */
		public function get Descricao():String { return descricao; }
		
		/**
		 * Método Public Get ContextMenu.
		 * 
		 * @return Variável contextMenu.
		 */
		public function get ContextMenu():Boolean { return contextMenu; }
		
		/**
		 * Método Public Get AreaInicial.
		 * 
		 * @return Variável areaInicial.
		 */
		public function get AreaInicial():Boolean { return areaInicial; }
		
		/**
		 * Método Public Get PlaceHolder.
		 * 
		 * @return Variável placeHolder.
		 */
		public function get PlaceHolder():String { return placeHolder; }
		
		/**
		 * Método Public Get Tag.
		 * 
		 * @return Variável tag.
		 */
		public function get Tag():String { return tag; }
		
		/**
		 * @private
		 */
		public function set ContextMenu(value:Boolean):void 
		{
			contextMenu = value;
		}
	}
	
}