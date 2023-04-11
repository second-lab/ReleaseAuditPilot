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
	import bulldog.core.BullDog;
	import flash.display.StageScaleMode;
	
  
	[SWF(width="1200", height="700", frameRate="60", backgroundColor="#ffffff")]
	
	public class MainDog extends BullDog
	{
		public function MainDog() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			super();
		}
	}
}