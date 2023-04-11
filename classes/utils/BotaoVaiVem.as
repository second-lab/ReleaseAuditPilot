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

package utils
{
	import flash.display.*;
	import flash.events.*;
	
	public dynamic class BotaoVaiVem extends MovieClip
	{
		
		private var mcMain:MovieClip;
		
		public function BotaoVaiVem()
		{
			this.gotoAndStop(1);

			var hit:MovieClip = MovieClip(this.getChildByName("hit"));
			
			if(hit==null)
			{
				mcMain = this;
			}
			else
			{
				mcMain = hit;				
			}
			
			mcMain.buttonMode = true;
			mcMain.addEventListener(MouseEvent.ROLL_OVER, over);
			mcMain.addEventListener(MouseEvent.ROLL_OUT, out);
		}
		
		public function lock(enable:Boolean):void
		{
			if (!enable)
			{
				this.gotoAndStop(this.totalFrames);
				mcMain.removeEventListener(MouseEvent.ROLL_OVER, over);
				mcMain.removeEventListener(MouseEvent.ROLL_OUT, out);
			}else
			{
				//this.gotoAndStop(1);
				new FrameControl(this , -1 , 1);
				mcMain.addEventListener(MouseEvent.ROLL_OVER, over);
				mcMain.addEventListener(MouseEvent.ROLL_OUT, out);
			}
		}
		
		
		public function over(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, volta);
			this.addEventListener(Event.ENTER_FRAME, vai);
		}
		
		public function out(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, vai);
			this.addEventListener(Event.ENTER_FRAME, volta);
		}
		
		public function vai(event:Event):void
		{
			this.nextFrame();
			if(this.currentFrame >= this.totalFrames)
			{
				this.removeEventListener(Event.ENTER_FRAME, vai);
			}
		}
		
		public function volta(event:Event):void
		{
			this.prevFrame();
			if(this.currentFrame == 1)
			{
				this.removeEventListener(Event.ENTER_FRAME, volta);
			}
		}
	}
}