package projeto.ui.vo 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Luiz Segundo
	 */
	public class GitBranch extends Object
	{
		
		private var key :String;
		private var name:String;
		private var type:String;
		private var version:String;
		private var versionOrderBy:String;
		private var latestCommitHash:String;
		private var branchSearchKey:String;
		private var numFoundInVersion:uint;
		private var mcProgress:MovieClip;
		private var mcLabel:MovieClip;
		private var arrGitTags:Array;
	
		public function get ArrGitTags ():Array { return arrGitTags; }
		
		public function set ArrGitTags(value:Array):void 
		{
			arrGitTags = value;
		}
		
		public function get McProgress ():MovieClip { return mcProgress; }
		
		public function set McProgress(value:MovieClip):void 
		{
			mcProgress = value;
		}
		
		public function get McLabel ():MovieClip { return mcLabel; }
		
		public function set McLabel(value:MovieClip):void 
		{
			mcLabel = value;
		}
		
		public function get Key ():String { return key; }
		
		public function set Key(value:String):void 
		{
			key = value;
		}
		
		public function get Type ():String { return type; }
		
		public function set Type(value:String):void 
		{
			type = value;
		}
		
		public function get Name ():String { return name; }
		
		public function set Name(value:String):void 
		{
			name = value;
		}
		
		public function get LatestcommitHash ():String { return latestCommitHash; }
		
		public function set LatestcommitHash(value:String):void 
		{
			latestCommitHash = value;
		}
		
		public function get Version ():String { return version; }
		
		public function set Version(value:String):void 
		{
			version = value;
		}
		
		public function get VersionOrderBy ():String { return versionOrderBy; }
		
		public function set VersionOrderBy(value:String):void 
		{
			versionOrderBy = value;
		}
		
		public function get BranchSearchKey ():String { return branchSearchKey; }
		
		public function set BranchSearchKey(value:String):void 
		{
			branchSearchKey = value;
		}
		
		public function get NumFoundInVersion ():uint { return numFoundInVersion; }
		
		public function set NumFoundInVersion(value:uint):void 
		{
			numFoundInVersion = value;
		}
		
		
		public function GitBranch(rs:Object = null) 
		{
			
		}
		
	}

}