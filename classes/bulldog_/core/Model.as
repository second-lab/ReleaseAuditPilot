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
	import bulldog.enums.EEnviroment;
	import bulldog.events.ModelEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;


	public class Model extends ModelProvider
	{
		/** 
		 * Variável uRLEnviroment:String. 
		 * 
		 * @default  
		 */
		private var uRLEnviroment:String;
		
		/** 
		 * Variável flashVars:Object. 
		 * 
		 * @default  
		 */
		private var flashVars:Object;
		
		/** 
		 * Variável oStage:Stage. 
		 * 
		 * @default  
		 */
		private var oStage:Stage;
		
		/** 
		 * Variável phAbove:MovieClip. 
		 * 
		 * @default  
		 */
		private var phAbove:MovieClip;
		
		/** 
		 * Variável phMiolo:MovieClip. 
		 * 
		 * @default  
		 */
		private var phMiolo:MovieClip;
		
		/**
		 * Método Public Get FlashVars.
		 * 
		 * @return flashVars.
		 */
		public function get FlashVars():Object 
		{ 
			if (flashVars == null )
			{
				flashVars = new Object();
			}
			return flashVars; 
		}
		
		/**
		 * @private
		 */	
		public function set FlashVars(value:Object):void 
		{
			flashVars = value;
		}
		
		/**
		 * @private
		 */		
		public function set URLEnviroment(value:String):void 
		{
			uRLEnviroment = value;
		}
		
		/**
		 * Método Public Get URLInfo.
		 * 
		 * @return EEnviroment.URLInfo.
		 * 
		 * @see bulldog.enums.EEnviroment.URLInfo
		 */
		public function get URLInfo():String {return EEnviroment.URLInfo; }
		
		/**
		 * @private
		 */	
		public function set URLInfo(value:String):void 
		{
			EEnviroment.URLInfo = value;
		}
		
		/**
		 * Método Public Get OStage.
		 * 
		 * @return oStage.
		 */
		public function get OStage():Stage { return oStage; }
		
		/**
		 * @private
		 */	
		public function set OStage(value:Stage):void 
		{
			oStage = value;
		}
		
		/**
		 * Método Public Get PhAbove.
		 * 
		 * @return phAbove.
		 */
		public function get PhAbove():MovieClip { return phAbove; }
		
		/**
		 * @private
		 */	
		public function set PhAbove(value:MovieClip):void 
		{
			phAbove = value;
		}
		
		/**
		 * Método Public Get PhAbove.
		 * 
		 * @return phMiolo.
		 */
		public function get PhMiolo():MovieClip { return phMiolo; }
		
		/**
		 * @private
		 */	
		public function set PhMiolo(value:MovieClip):void 
		{
			phMiolo = value;
		}
		
		/**
		 * Construtor Model.
		 */
		public function Model()
		{
			addEventListener(ModelEvent.LOAD_DATAPROVIDER , InitializeModel);
		}
		
		/**
		 * Método Protected InitializeModel.
		 * 
		 * @param e:ModelEvent Evento
		 */
		protected function InitializeModel(e:ModelEvent):void
		{
			dispatchEvent(new ModelEvent(ModelEvent.SETUP_COMPLETE, e.XmlConfig));
		}
		
		/**
		 * Método Public GetValue.
		 * 
		 * @param nameKey:String Variável
		 * @param node:String
		 * @param env:String
		 */
		public function GetValue(nameKey:String , node:String = null , env:String = null):*
		{
			var xmlPath:XMLList;
			
			if (node == null)
			{
				xmlPath = xmlConfig.param;
			}
			else
			{
				xmlPath = xmlConfig[node].param;
			}
			
			for each(var name:* in xmlPath)
			{
				if (nameKey == name.@name)
				{
					if (env != null)
					{
						if (env == name.@enviroment)
						{
							if (!isNaN(name.@value) && name.@value!="")
							{
								return int(name.@value);
							}
							return name.@value;
						}
					}
					else
					{
						if (!isNaN(name.@value) && name.@value!="")
						{
							return int(name.@value);
						}
						return name.@value;
					}
				}
			}
			return null;
		}
	}
	
}