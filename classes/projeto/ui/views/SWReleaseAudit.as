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

 

package projeto.ui.views
{
	import bulldog.api.IBasicView;
	import bulldog.templates.BasicView;
	import projeto.ui.vo.GitCommits;
	import projeto.ui.vo.GitReleaseNotes;
	
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;

	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;

	import flash.xml.XMLDocument;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.display.MovieClip;
	
	
	
	import utils.BotaoVaiVem;

	import caurina.transitions.Tweener;

	
	import bulldog.core.Navigation;
	
	import projeto.SiteFacade;
 
	import flash.text.TextFieldAutoSize;
	
	import flash.display.DisplayObject;
	
	import flash.system.fscommand;
		
	import bulldog.events.CommitsEvent;
	
	import projeto.ui.vo.SWAudit;
	
	import projeto.ui.vo.GitBranch;
	
	import bulldog.core.Log;
	
	public class SWReleaseAudit extends BasicView implements IBasicView
	{
		
		private var geoReq:URLRequest = new URLRequest;
        private var geoLoader:URLLoader = new URLLoader();
        private var GeocodeResponse:XML;
        private var geoLocList:XMLList = new XMLList();
        private var geoLoc:Array = new Array();
		
	
		private var ArrVersionIssues:Array;
		
		
		private var ArrOSWAudit:Array;
		
		public function SWReleaseAudit() 
		{
			
		}
		
		override public function InitObjects():void 
		{
			trace(">>>>>>");
			//
			Log.Print("Jira HOST      : " + SiteFacade.Instance.OModel.GetValue("jira_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")));
			Log.Print("Bitbucket HOST : " + SiteFacade.Instance.OModel.GetValue("jira_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")));
			
			McMain.mcAddReleaseForm.btAdd.buttonMode = true;
			McMain.mcAddReleaseForm.btAdd.addEventListener(MouseEvent.CLICK, onClickAddReleaseNotes );
			
			McMain.btLoadJira.buttonMode = true;
			McMain.btLoadJira.addEventListener(MouseEvent.CLICK, OnClickLoadJira);
			
			McMain.mcGitInfo.mcMais.btMais.buttonMode = true;
			McMain.mcGitInfo.mcMais.btMais.addEventListener(MouseEvent.CLICK, OnClickAddGit);
			
			//McMain.mcAddReleaseForm.buttonMode = true;
			McMain.mcAddReleaseForm.btLoad.buttonMode = true;
			McMain.mcAddReleaseForm.btLoad.addEventListener(MouseEvent.CLICK, OnClickLoadFile );
			
			McMain.mcBlockBg.alpha = 0;
			McMain.mcBlockBg.mouseEnabled = false;
			McMain.mcBlockBg.addEventListener(MouseEvent.CLICK , OnClickBlockBg);
			
			
			McMain.mcDialog.alpha = 0;
			McMain.mcDialog.visible = false;
			
			var fncClose:Function = function():void { ShowDialog(false); };
			McMain.mcDialog.mcClose.addEventListener(MouseEvent.CLICK , fncClose);

			
			
			McMain.mcAddReleaseForm.txtReleaseNote.addEventListener(Event.CHANGE, OnTextFieldChange );
			McMain.txtSWVersion.addEventListener(Event.CHANGE, OnTextFieldJiraChange );
			
			McMain.mcAddReleaseForm.txtReleaseNote.text = "";
			
			McMain.txtSWVersion.restrict = "A-Z 0-9 \\_\\.";
			
			
			EnableDisable(McMain.mcAddReleaseForm.btAdd , false);	
			//EnableDisable(McMain.btLoadJira , false);
			
			McMain.mcAddReleaseForm.x = 1710;
			
			McMain.txtSWVersion.text = "APP_1_V11.7.0";
			
			McMain.mcAddReleaseForm.mcSuggestion.alpha = 0;
			McMain.mcAddReleaseForm.mcSuggestion.mcBgSugg.mouseEnabled = false;
			McMain.mcAddReleaseForm.mcSuggestion.btAddCompare.mouseEnabled = true;
			McMain.mcAddReleaseForm.mcSuggestion.btAddCompare.buttonMode = true;
			McMain.mcAddReleaseForm.mcSuggestion.btAddManually.buttonMode = true;
			McMain.mcAddReleaseForm.mcSuggestion.btAddCompare.addEventListener(MouseEvent.CLICK , onClickAddCompare);
			McMain.mcAddReleaseForm.mcSuggestion.btAddManually.addEventListener(MouseEvent.CLICK , onClickAddManually);
			
			
			McMain.mcAddReleaseForm.txtFeedbackRn.text = "";
			McMain.mcAddReleaseForm.btGenerateRn.mouseEnabled = true;
			McMain.mcAddReleaseForm.btGenerateRn.addEventListener(MouseEvent.CLICK , OnClickGenerateRn);
			
			McMain.mcAddReleaseForm.txtReleaseNoteLabel.addEventListener(Event.CHANGE, OnTextFieldGitChange );
			McMain.mcAddReleaseForm.txtBranchInclude.addEventListener(Event.CHANGE, OnTextFieldGitChange );
			McMain.mcAddReleaseForm.txtBranchExclude.addEventListener(Event.CHANGE, OnTextFieldGitChange );
			
			EnableDisable(McMain.mcAddReleaseForm.btGenerateRn , false);
			
			
			
			McMain.mcAddReleaseForm.btWizard.mouseEnabled = true;
			McMain.mcAddReleaseForm.btWizard.addEventListener(MouseEvent.CLICK , OnClickWizard);
			
			
			UpdateStatus(true);			
		}
		
		private function OnClickWizard(e:MouseEvent):void
		{
			McMain.mcAddReleaseForm.mcSuggestion.x = 0;
			McMain.mcAddReleaseForm.mcSuggestion.alpha = 1;
			McMain.mcAddReleaseForm.mcSuggestion.visible = true;
			Tweener.addTween(McMain.mcAddReleaseForm.mcSuggestion, {x:-481, time:.6, transition:"EasyInOut"});
		}
		
		private function onClickAddManually(e:MouseEvent):void
		{
			Tweener.addTween(McMain.mcAddReleaseForm.mcSuggestion, {x:0, time:.6, transition:"EasyOutIn"});
		}
		
		private function OnClickGenerateRn(e:MouseEvent):void
		{
			
			BitBucketGetCommitsList(McMain.mcAddReleaseForm.txtBranchInclude.text,  McMain.mcAddReleaseForm.txtBranchExclude.text , McMain.mcAddReleaseForm.txtReleaseNoteLabel.text,OnLoadBitbucketCommitList);
		}
		
		private function OnClickBlockBg(e:Event):void
		{
			ShowHideReleaseNotes(false);
		}
		
		private function OnTextFieldChange(e:Event):void
		{
			EnableDisable(McMain.mcAddReleaseForm.btAdd, McMain.mcAddReleaseForm.txtReleaseNote.text != "" && String(McMain.mcAddReleaseForm.txtReleaseNote.text).length > 6);
		}
		
		private function OnTextFieldGitChange(e:Event):void
		{
			if ((McMain.mcAddReleaseForm.txtReleaseNoteLabel.text != "" && String(McMain.mcAddReleaseForm.txtReleaseNoteLabel.text).length >= 5 ) 
			&& (McMain.mcAddReleaseForm.txtBranchInclude.text != "" && String(McMain.mcAddReleaseForm.txtBranchInclude.text).length == 40)
			&&(McMain.mcAddReleaseForm.txtBranchExclude.text != "" && String(McMain.mcAddReleaseForm.txtBranchExclude.text).length == 40))
			{
				EnableDisable(McMain.mcAddReleaseForm.btGenerateRn, true);
			}
			else
			{
				EnableDisable(McMain.mcAddReleaseForm.btGenerateRn, false);
			}
		}
		
		private function OnTextFieldJiraChange(e:Event):void
		{
			EnableDisable(McMain.btLoadJira, e.currentTarget.text != "" && String(e.currentTarget.text).length > 6);
		}
		
		private function EnableDisable(target:MovieClip , enabled:Boolean):void
		{
			if (enabled)
			{
				Tweener.addTween(target, {alpha:1, time:.3,transition:"linear"});
			}
			else{
				Tweener.addTween(target, {alpha:.3, time:.3,transition:"linear"});
			}
			target.mouseEnabled = enabled;
		}
		
		private function OnClickLoadJira(e:Event):void
		{
			
			//var reg:RegExp = /^(APP)\_([0-9]{1,2})_V([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{1,2}$)|(APP)\_([0-9]{1,2})_V([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{1,2})([_])(RC)([0-9]{1,2})/gi;
			var reg:RegExp = /^(APP)\_([0-9]{1,2})_V([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{1,2}$)/gi;
			
			
			
			if (McMain.txtSWVersion.text !="" && String(McMain.txtSWVersion.text).length > 6 && reg.test(McMain.txtSWVersion.text))
			{
				Log.Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> JIRA: OnClickLoadJira Called <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
				
				Navigation.McLoading.alpha=0;
				Navigation.McLoading.visible=true;
				
				//HERE
				Tweener.addTween(Navigation.McLoading, {alpha:1, time:.3, transition:"linear", onComplete:GetJiraReleaseIssues}); ///START
				
				ShowHideReleaseNotes(false);	
				
				var version:String = String(McMain.txtSWVersion.text).split("_V")[1].replace(" ", "");
				
				var comp:String = String(McMain.txtSWVersion.text).split("_V")[0].replace(" ", "");
				
				var branch:String;
				
				if (comp == "APP_1")
				{
					branch = String(McMain.txtSWVersion.text).split("_V")[0] + "_RX_V" + String(McMain.txtSWVersion.text).split("_V")[1].substr(0, 3).replace(" ", "");
				}
				else if (comp == "APP_9")
				{
					branch = String(McMain.txtSWVersion.text).split("_V")[0] + "_V" + String(McMain.txtSWVersion.text).split("_V")[1].substr(0, 3).replace(" ", "");
				}
				
				UpdateStatus(true);
				
				//start
				OSWAuditCurrentSession                 = new SWAudit();
				OSWAuditCurrentSession.Key             = String(McMain.txtSWVersion.text).replace(" ", "");
				OSWAuditCurrentSession.Name            = String(McMain.txtSWVersion.text).replace(" ", "");
				OSWAuditCurrentSession.BranchName      = branch;
				OSWAuditCurrentSession.Version         = version;
				OSWAuditCurrentSession.BranchSearchKey = branch.split(".")[0];
				OSWAuditCurrentSession.ArrReleaseNotes = new Array();
				OSWAuditCurrentSession.ArrGitIssues    = new Array();
				
				//
				//TODO
				BitBucketGetBranches(OSWAuditCurrentSession.BranchSearchKey);
			}
			else{
				McMain.txtFeedbackJira.text = "Type the Jira version name you want to load issues"
			}
		}
		
		private function GetJiraReleaseIssues():void
		{			
			Log.Print(">>>>> JIRA: GetJiraReleaseIssues Called");
			
			var StrSearch:String = String(McMain.txtSWVersion.text).replace(" ", "" );
			
			var urlReq:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("jira_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")) + "getJiraIssues.php?v=" + StrSearch + "&r=" + Math.random());
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, ParseJiraIssues);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadJiraError);
            loader.load(urlReq);
		}
		
		private function onLoadJiraError(e:IOErrorEvent):void
		{
			//trace("Error loading JIRA issues : " + e.text);
			
			ShowDialog(true , "Unable to connect!" , e.text);
			
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
		}
		
		
		private function SaveCurrentAudit():void
		{
			for (var i:int = 0; i < ArrOSWAudit.length; i++) 
			{
				if (SWAudit(ArrOSWAudit[i]).Key)
				{
					
				}
			}
		}
		
		private function ParseJiraIssues( e:Event ):void
        {
			
			Log.Print(">>>>> JIRA: ParseJiraIssues Called");

			
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
            if ( e.target.data )
            {
				var obj:Object = new Object()
				obj = JSON.parse(String(e.target.data));
				
				if (obj["errorMessages"] == undefined)
				{
				
					ArrVersionIssues = new Array();
				
					for (var ob:Object in obj)
					{
						ArrVersionIssues.push({key:obj[ob].key, summary:obj[ob].summary, type:obj[ob].type, status:obj[ob].status});
					}
					
					
					CreateIssuesList();
					
					McMain.txtFeedbackJira.text = "";
				}
				else
				{
					McMain.txtFeedbackJira.text = "The value \"" + OSWAuditCurrentSession.Key + "\" is not a valid JIRA Version name."; //obj["errorMessages"];
				}
            }
        }
		
		
		////
		
		
		
		private function CreateIssuesList():void
		{
			
			Log.Print(">>>>> JIRA: CreateIssuesList Called");
			
			ArrStatusIssues = new Array();
				
			var MenuItemPosX:Number = 0;
			var MenuItemPosY:Number = 0;
			var Delay:Number = 0;
			
			while(McMain.mcGitInfo.mcPhnotes.numChildren>0)
			{
				McMain.mcGitInfo.mcPhnotes.removeChildAt(0);
			}
			
			while(McMain.mcPhbase.mcPhIssues.numChildren>0)
			{
				McMain.mcPhbase.mcPhIssues.removeChildAt(0);
			}
		
			var InitY:Number = 0;
			
			for (var i:uint = 0; i < ArrVersionIssues.length;i++ )
			{
				var OItemClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("IssueItem") as Class;
				var MoItem:MovieClip = new OItemClass() as MovieClip;
				MoItem.visible = true;
				
				var McItem:MovieClip = McMain.mcPhbase.mcPhIssues.addChild(MoItem);
				
				McItem.y = InitY;
				
				McItem.alpha = 0;
				Tweener.addTween(McItem, {alpha:1, time:.3, delay:Delay,transition:"linear"});
				
				Delay +=.01;

				//McItem.mcGitInfo.visible = false;
				McItem.name = ArrVersionIssues[i].key;
				McItem.txtInc.text = i+1;
				McItem.txtKey.text = ArrVersionIssues[i].key;
				McItem.txtSummary.text = ArrVersionIssues[i].summary;
				//McItem.txtStatus.text = ArrVersionIssues[i]["status"].name;
				
				McItem.type = ArrVersionIssues[i]["type"].name;
				McItem.status = ArrVersionIssues[i].status;
				McItem.mcIconType.gotoAndStop(ArrVersionIssues[i]["type"].name);
				
				McItem.cacheAsBitmap = true;
				
				McItem.mouseEnabled = true;
				McItem.mouseChildren = false
				McItem.buttonMode = true;
				McItem.addEventListener(MouseEvent.CLICK, PopulateSWItem)

				InitY += McItem.height;
				
				McItem.mcStatus.gotoAndStop(String(ArrVersionIssues[i]["status"].name).toLowerCase());
				
				CreateIssueStatusList(ArrVersionIssues[i]["status"].name);
				
			
				
			}
			
			McMain.spIssues.source = McMain.mcPhbase.mcPhIssues;
			
			//CheckSuggestedBranches();
			
			AddCompareReleaseNotes(false);
			
			if(OSWAuditCurrentSession.ArrGitBranches != null) if(OSWAuditCurrentSession.ArrGitBranches.length>0)UpdateStatus();
		}
		////
		
		private var ArrStatusIssues:Array = [];
		
		private var numClosedIssues:uint = 0;
		
		private var OSWAuditCurrentSession:SWAudit;
		
		private function CreateIssueStatusList(strStatus:String):void
		{
			var vFound:Boolean = false;
				
			for (var z:uint = 0; z < ArrStatusIssues.length;z++)
			{

				if (strStatus == ArrStatusIssues[z].name)
				{ 
					ArrStatusIssues[z].count = Number(ArrStatusIssues[z].count) +1;
					
					vFound = true;
				}
			}
			
			if(!vFound)ArrStatusIssues.push({name:strStatus , count:"1" });
		}
		
		
		private function UpdateStatus(clean:Boolean = false):void
		{
			//trace("Start")
			
			if (OSWAuditCurrentSession != null)
			{
				//trace("IF")
				//trace("UPDATE HEAD: " + OSWAuditCurrentSession.GitHead.NumFoundInVersion  , ArrVersionIssues.length)
				//trace("UPDATE RC: " + OSWAuditCurrentSession.GitRC.NumFoundInVersion  , ArrVersionIssues.length)
			}
				
			
			
			if (clean)
			{
				McMain.mcStatus.txtStatusTitle.text = "";
				McMain.mcStatus.txtStatusLine1.text = "";
				McMain.mcStatus.txtStatusLine2.text = "";
				McMain.mcStatus.txtStatusLine3.text = "";
				
				numIssuesFoundInHEAD = 0;
				
			}
			else{
				
				var Closed:uint = 0;
			
				if (GetStatusArr("Closed")) Closed = GetStatusArr("Closed").count;
				
				McMain.mcStatus.txtStatusTitle.text = OSWAuditCurrentSession.Key + " Release Status";
				McMain.mcStatus.txtStatusLine1.text = "JIRA total : " + ArrVersionIssues.length;
				McMain.mcStatus.txtStatusLine2.text = "JIRA closed: " + Closed;
				McMain.mcStatus.txtStatusLine3.text = "Found in X.X.X: " + OSWAuditCurrentSession.GitHead.NumFoundInVersion;
				
				McMain.mcStatus.mcProgress.mcBarraGreen.scaleX = Closed  / ArrVersionIssues.length;
				
				
				
				if (OSWAuditCurrentSession.GitHead.McProgress != null) 
				{
					OSWAuditCurrentSession.GitHead.McProgress.mcBarraGreen.scaleX = OSWAuditCurrentSession.GitHead.NumFoundInVersion  / ArrVersionIssues.length;
					OSWAuditCurrentSession.GitHead.McProgress.visible = true;
				}
				
				if (OSWAuditCurrentSession.GitRC != null)
				{
					if (OSWAuditCurrentSession.GitRC.McProgress != null) 
					{
						
						
						OSWAuditCurrentSession.GitRC.McProgress.mcBarraGreen.scaleX = OSWAuditCurrentSession.GitRC.NumFoundInVersion  / ArrVersionIssues.length;
						OSWAuditCurrentSession.GitRC.McProgress.visible = true;
					}
				}
			}
			McMain.mcStatus.visible = !clean;
		}
		
		
		private function GetStatusArr(strStatus:String):Object
		{
			for (var i:int = 0; i < ArrStatusIssues.length; i++) 
			{
				if (ArrStatusIssues[i].name == strStatus)
				{
					return ArrStatusIssues[i];
				}
			}
			return null;
		}
		
		import flash.net.navigateToURL;
		
		private function PopulateSWItem(e:Event):void
		{
			var JiraLink:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("jirahost" , "urls") + e.currentTarget.name);
			navigateToURL(JiraLink, "_blank");
			
			
		}
		
		//APP_1_V11.5.0
		
		private function onClickAddReleaseNotes(e:Event):void
		{
			if (McMain.mcAddReleaseForm.txtReleaseNote.text !="" && String(McMain.mcAddReleaseForm.txtReleaseNote.text).length > 0)
			{
				ParseCSV(McMain.mcAddReleaseForm.txtReleaseNote.text, McMain.mcAddReleaseForm.txtReleaseNoteLabel.text , false);
			}
			else{
				//BrowserFile();
			}
		}
		
		private var fr:FileReference;
		private static const FILE_TYPES:Array = [new FileFilter("CSV File", "*.csv"),new FileFilter("TXT File", "*.text")];
		//private static const FILE_TYPES:Array = [new FileFilter("XML File", "*.xml")];
		
		private function OnClickLoadFile(e:Event):void
		{
			//create the FileReference instance
			fr = new FileReference();

			//listen for when they select a file
			fr.addEventListener(Event.SELECT, onFileSelect);

			//listen for when then cancel out of the browse dialog
			fr.addEventListener(Event.CANCEL,onCancel);

			//open a native browse dialog that filters for text files
			fr.browse(FILE_TYPES);
		}
		
		/************ Browse Event Handlers **************/

		//called when the user selects a file from the browse dialog
		private function onFileSelect(e:Event):void
		{
			//listen for when the file has loaded
			fr.addEventListener(Event.COMPLETE, onLoadComplete);

			//listen for any errors reading the file
			fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);

			//load the content of the file
			fr.load();
			
			McMain.mcAddReleaseForm.fileNameField.text = "";
		}

		//called when the user cancels out of the browser dialog
		private function onCancel(e:Event):void
		{
			trace("File Browse Canceled");
			McMain.mcAddReleaseForm.fileNameField.text = "";
			fr = null;
		}

		/************ Select Event Handlers **************/

		//called when the file has completed loading
		private function onLoadComplete(e:Event):void
		{
			//get the data from the file as a ByteArray
			var data:ByteArray = fr.data;

			//read the bytes of the file as a string and put it in the
			
			McMain.mcAddReleaseForm.txtReleaseNote.text = fr.data;
			
		
			//Implement release note name sugestion in the filed
			//McMain.mcAddReleaseForm.txtReleaseNoteLabel.text = "";
			
			var filename:String = String(fr.name).split(".csv")[0]
			
			McMain.mcAddReleaseForm.txtReleaseNoteLabel.text = filename.substr(0, 14) + "...";
		
			if ((fr.data != null) && (filename.length > 0))
			{
				EnableDisable(McMain.mcAddReleaseForm.btAdd , true);	
			}
			McMain.mcAddReleaseForm.fileNameField.text = fr.name;
		}
		
		//called if an error occurs while loading the file contents
		private function onLoadError(e:IOErrorEvent):void
		{
			//trace("Error loading file : " + e.text);
			ShowDialog(true , "Error loading file!" , e.text);
		}
		
		//*****PARSE
	
		
		
		
		private function ParseCSV(data:Object , label:String , json:Boolean = false):void
		{
			Log.Print(">>>>> GIT: ParseCSV Called (" + label + ")");
			
			var OGitReleaseNotes:GitReleaseNotes = new GitReleaseNotes();
			OGitReleaseNotes.Name    = label;
			OGitReleaseNotes.Version = label;
			OGitReleaseNotes.ArrCommits = new Array();
			
			var OGitCommits:GitCommits = new GitCommits();

			var ArrRNItem:Array;
			ArrRNItem = new Array();
			
			var ArrRNIssues:Array = new Array();
			ArrRNIssues = String(data).split("SSP-"); //TODO set input to uppercase
			
			var arrTempo:Array = new Array();
			
			for (var i:uint = 0; i < ArrRNIssues.length;i++)
			{
				
				var str:String = String(ArrRNIssues[i]).substr(0, 5);
				str = str.replace(":", "").replace(" ", "").replace("-", "");
				
				if (isNaN(Number(str))) continue;
				
				str = "SSP-" + str;
				
				if (!CheckDuplicated(arrTempo , str , "JiraKey"))
				{
					arrTempo.push({JiraKey:str});
				}
				
			}
			
			OGitReleaseNotes.ArrCommits = arrTempo;

			Log.Print(">>>>>>>>> ParseCSV  : ArrRNIssues :" + ArrRNIssues.length);
			Log.Print(">>>>>>>>> ParseCSV  : arrTempo    :" + arrTempo.length);
			//trace("OGitReleaseNotes.ArrCommits " + OGitReleaseNotes.ArrCommits.length);			
			
			
			EnableDisable(McMain.mcAddReleaseForm.btAdd , false);	
			
			//Tweener.addTween(McMain.mcAddReleaseForm, {alpha:0, time:.3, transition:"linear", onComplete: function(){McMain.mcAddReleaseForm.visible = false; }});
			
			ShowHideReleaseNotes(false,0.5);	
			
			
			McMain.mcAddReleaseForm.fileNameField.text = "";
			
			//McMain.mcAddReleaseForm.txtReleaseNote.text = "";
			
			if (label.indexOf("RC") == -1)
			{
				OSWAuditCurrentSession.ArrReleaseNotes.push(OGitReleaseNotes);
				
				if (arrSuggestionCalls != null)
				{
					if (arrSuggestionCalls.length >=1) 
					{
						Log.Print(">>>>>>>>> ParseCSV : IF arrSuggestionCalls.length : " + arrSuggestionCalls.length);
						
						BitBucketGetCommitsList(arrSuggestionCalls[0].hash_include, arrSuggestionCalls[0].hash_exclude , arrSuggestionCalls[0].hash_label, OnLoadBitbucketCommitList);
						
						arrSuggestionCalls.shift();
					}
					else
					{
						Log.Print(">>>>>>>>> ParseCSV : ELSE arrSuggestionCalls.length : " + arrSuggestionCalls.length);
						
						if (OSWAuditCurrentSession.GitRC != null)
						{
							BitBucketGetTags(OSWAuditCurrentSession.Key);
						}
						else
						{
							if(OSWAuditCurrentSession.ArrGitBranches != null) if(OSWAuditCurrentSession.ArrGitBranches.length>0)CreateReleaseNotesLabelMenu();
						}
						
						Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
					}
				}
				else
				{
					Log.Print(">>>>>>>>> UpdateIssuesList : NULL ");
					
				/*	if (OSWAuditCurrentSession.GitRC != null)
					{
						BitBucketGetTags(OSWAuditCurrentSession.Key);
					}
					else
					{
						CreateReleaseNotesLabelMenu();
					}*/
					
					Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
				}
			}
			else
			{
				OSWAuditCurrentSession.ArrTagReleaseNotes.push(OGitReleaseNotes);
				
				GetReleaseNotesForRCTags();
			}
		}
		
		
		private function CreateReleaseNotesLabelMenu():void
		{
			Log.Print(">>>>> GIT: CreateReleaseNotesLabelMenu Called ");
			
			var Delay:Number = 0;
			var InitX:Number = 0;	
			
			while(McMain.mcGitInfo.mcPhnotes.numChildren>0)
			{
				McMain.mcGitInfo.mcPhnotes.removeChildAt(0);
			}
			
			OSWAuditCurrentSession.GitHead.NumFoundInVersion = 0;
			
			if(OSWAuditCurrentSession.GitRC != null)OSWAuditCurrentSession.GitRC.NumFoundInVersion   = 0;
			
			for (var i:uint = 0; i < OSWAuditCurrentSession.ArrReleaseNotes.length;i++ )
			{
				var OItemClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("mclabel") as Class;
				var MoItem:MovieClip = new OItemClass() as MovieClip;
				MoItem.visible = true;
				
				var McItem:MovieClip = McMain.mcGitInfo.mcPhnotes.addChild(MoItem);
				
				
				
				McItem.alpha = 0;
				McItem.name = String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).Name).toUpperCase();
				Tweener.addTween(McItem, {alpha:1, time:.3, delay:Delay,transition:"linear"});
				
				Delay +=.01;

				
				McItem.mcProgress.visible = false;
				McItem.mcProgress.mcBarraGreen.scaleX = 0;
				
				McItem.txtLabel.autoSize = TextFieldAutoSize.LEFT;
				
				McItem.txtLabel.mouseEnabled = false;
				McItem.txtLabel.text = String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).Name).toUpperCase();
				
				McItem.btRemove.x = McItem.txtLabel.x + McItem.txtLabel.textWidth +10;
				McItem.mcBg.width = McItem.btRemove.x +15;
				
				
				
				var strversion:String = OSWAuditCurrentSession.Key.split(".")[0];
				
				var strMod:String = strversion.split("_")[2] + ".X.X"; //THIS SHOULD BE DINAMIC BASED ON THE VERSION INPUT FIELD OR TEXT GENERATED
				
								
				if (String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).Version.toLowerCase()).indexOf(strMod.toLowerCase()) != -1)
				{
					OSWAuditCurrentSession.GitHead.McProgress = McItem.mcProgress;
					OSWAuditCurrentSession.GitHead.McLabel    = McItem;
				} 
				else if (GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).Version == ("V"+OSWAuditCurrentSession.Version))
				{
					OSWAuditCurrentSession.GitRC.McProgress = McItem.mcProgress;
					OSWAuditCurrentSession.GitRC.McLabel    = McItem;
					
					McItem.mcRCPh.x = McItem.txtLabel.x + McItem.txtLabel.textWidth + 10;
					
					var IniXX:Number = 0;
					
					if (OSWAuditCurrentSession.ArrTagReleaseNotes != null)
					{
					
						for (var j:int = 0; j < OSWAuditCurrentSession.ArrTagReleaseNotes.length; j++) 
						{
							var OItemClassRC:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("labelrc") as Class;
							var MoItemRC:MovieClip = new OItemClassRC() as MovieClip;
							MoItemRC.visible = true;
					
							
							
							var McItemRC:MovieClip = McItem.mcRCPh.addChild(MoItemRC);
							McItemRC.txtRC.autoSize =  TextFieldAutoSize.LEFT;
							McItemRC.txtRC.text = " " + OSWAuditCurrentSession.ArrTagReleaseNotes[j].Name + " ";
							McItemRC.txtRC.backgroundColor = 0xF2F2F2;
							McItemRC.x =  IniXX;
							
							IniXX += McItemRC.width +5;
						}
					
					}
					McItem.btRemove.x = McItem.mcRCPh.x + McItem.mcRCPh.width +10;
					McItem.mcBg.width = McItem.btRemove.x +15;
					
					//OSWAuditCurrentSession.ArrTagReleaseNotes
				}
				else
				{
					GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).GitHead.McLabel = McItem;
				}
				
				McItem.mcProgress.width = McItem.mcBg.width;
				
				
				McItem.cacheAsBitmap = true;
				
				McItem.mouseEnabled = true;
				//McItem.mouseChildren = false
				McItem.buttonMode = true;

				McItem.x = InitX;
				
				InitX = McItem.x + McItem.mcBg.width +10;
				
				
				GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommitsFoundinJira = new Array();
				
				for (var k:int = 0; k < GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length; k++) 
				{
					if (McMain.mcPhbase.mcPhIssues.getChildByName(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits[k].JiraKey) == null)
					{
						GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommitsFoundinJira.push(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits[k].JiraKey);
						
						
						if (!CheckDuplicated(OSWAuditCurrentSession.ArrGitIssues , OSWAuditCurrentSession.ArrReleaseNotes[i].ArrCommits[k].JiraKey , "key" ))
						{
							OSWAuditCurrentSession.ArrGitIssues.push({key: OSWAuditCurrentSession.ArrReleaseNotes[i].ArrCommits[k].JiraKey});
						}
					}
					else
					{
						var strversionIn:String = OSWAuditCurrentSession.Key.split(".")[0];
								
						var strModIn:String = strversionIn.split("_")[2] + ".X.X"; //THIS SHOULD BE DINAMIC BASED ON THE VERSION INPUT FIELD OR TEXT GENERATED
						
						if (String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).Version.toLowerCase()).indexOf(strModIn.toLowerCase()) != -1)
						{
							OSWAuditCurrentSession.GitHead.NumFoundInVersion++;
							
							//if(OSWAuditCurrentSession.GitHead.McLabel!=null)OSWAuditCurrentSession.GitHead.McLabel.mcStatus.txtStatus.text = GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length -  OSWAuditCurrentSession.GitHead.NumFoundInVersion + " not in JIRA";
							if(OSWAuditCurrentSession.GitHead.McLabel!=null)OSWAuditCurrentSession.GitHead.McLabel.mcStatus.txtStatus.text = "(" + OSWAuditCurrentSession.GitHead.NumFoundInVersion + " / " + GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length + ") in JIRA";
							
							//if(OSWAuditCurrentSession.GitHead.McLabel!=null)OSWAuditCurrentSession.GitHead.McLabel.mcStatus.txtStatus.text = "(" + OSWAuditCurrentSession.GitHead.NumFoundInVersion + " / " +  (OSWAuditCurrentSession.ArrGitIssues.length + OSWAuditCurrentSession.GitRC.NumFoundInVersion) + ") in JIRA";
						
						} else if ((GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).Version) == ("V"+OSWAuditCurrentSession.Version))
						{
							OSWAuditCurrentSession.GitRC.NumFoundInVersion++;
							
							//if(OSWAuditCurrentSession.GitRC.McLabel!=null)OSWAuditCurrentSession.GitRC.McLabel.mcStatus.txtStatus.text = GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length - OSWAuditCurrentSession.GitRC.NumFoundInVersion + " not in JIRA";
							if(OSWAuditCurrentSession.GitRC.McLabel!=null)OSWAuditCurrentSession.GitRC.McLabel.mcStatus.txtStatus.text = "("+ OSWAuditCurrentSession.GitRC.NumFoundInVersion + " / " + GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length + ") in JIRA";
							
							//if(OSWAuditCurrentSession.GitRC.McLabel!=null)OSWAuditCurrentSession.GitRC.McLabel.mcStatus.txtStatus.text = "("+ OSWAuditCurrentSession.GitRC.NumFoundInVersion + " / " + (OSWAuditCurrentSession.ArrGitIssues.length + OSWAuditCurrentSession.GitRC.NumFoundInVersion) + ") in JIRA";
						}
						else{
							
							GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).GitHead.NumFoundInVersion++;
						}
					}
				}
				
				var arrTempoNotes:String;
				arrTempoNotes = String(OSWAuditCurrentSession.ArrReleaseNotes[i].ArrCommitsFoundinJira);
								
				McItem.mcStatus.mouseChildren = false;
				McItem.mcStatus.mouseEnabled = true;
				McItem.mcStatus.addEventListener(MouseEvent.CLICK , ShowGitNotFound);
				
				McItem.ArrNotFound = arrTempoNotes;
				
				
				if (GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).GitHead.McLabel != null)
				{
					GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).GitHead.McLabel.mcStatus.txtStatus.text = "(" + GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).GitHead.NumFoundInVersion + " / " + GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length + ") in JIRA";
					//GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).GitHead.McLabel.mcStatus.txtStatus.text = GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length - (GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommits.length-GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[i]).ArrCommitsNotFoundinJira.length) + " not in JIRA";
				}
			}

			UpdateStatus();
			
			
			
			UpdateIssuesList();
			
			
			CreateGetJiraIssueDetails();
		}
		
		private var numIssuesFoundInHEAD:Number = 0;
	
		
		private function CreateGetJiraIssueDetails():void
		{
			Log.Print(">>>>> JIRA: CreateGetJiraIssueDetails Called");
			 
			var ArrayIssues:Array = new Array();

			if (String(OSWAuditCurrentSession.ArrGitIssues[0]).indexOf("SSP") == -1)
			{
				
				for (var i:int = 0; i < OSWAuditCurrentSession.ArrGitIssues.length; i++) 
				{
					ArrayIssues.push(OSWAuditCurrentSession.ArrGitIssues[i].key);
				}
			}
			else
			{
				ArrayIssues = OSWAuditCurrentSession.ArrGitIssues;
			}
			
			var urlReq:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("jira_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")) + "getJiraIssuesDetails.php?v=" + ArrayIssues + "&r=" + Math.random());
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, ParseJiraIssueDetails);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadJiraError);
            loader.load(urlReq);	
		}
		
		
		private function ParseJiraIssueDetails( e:Event ):void
        {
			
			Log.Print(">>>>> JIRA: ParseJiraIssueDetails Called");
			
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
            
			
			
			if ( e.target.data )
            {
				
				var obj:Object = new Object()
				obj = JSON.parse(String(e.target.data));
				
				if (obj["errorMessages"] == undefined)
				{
				
					OSWAuditCurrentSession.ArrGitIssues = new Array();
				
					for (var ob:Object in obj)
					{
										
						var fixversion:Array;
						var resolution:Object;
						
						if (obj[ob].resolution != null) resolution = obj[ob].resolution;
						if (obj[ob].fixversions != null && obj[ob].fixversions != "") fixversion = new Array(obj[ob].fixversions);
					
					
						if (resolution != null)
						{
							//REMOVE NOT AN ISSUE FROM LIST
							if (resolution.name == "Fixed")
							{
						
								if (JSON.stringify(fixversion).indexOf("NO_SW_CHANGE") == -1 )
								{
									OSWAuditCurrentSession.ArrGitIssues.push({key:obj[ob].key, summary:obj[ob].summary, type:obj[ob].type, status:obj[ob].status , resolution:obj[ob].resolution , fixVersions:obj[ob].fixversions});
								}
							}
						}
					}
				}
				else
				{
					McMain.txtFeedbackJira.text = "The value is not a valid JIRA Issues name."; //obj["errorMessages"];
				}
				//
				
				
				ApendJiraIssuesFromGit();
            }
        }
		
		private function ApendJiraIssuesFromGit():void 
		{
			
			if (McMain.mcPhbase.mcPhIssues.getChildByName("PhGitIssues") != null)
			{
				return;
			}
			
			var InitY:Number = 0;
			var Delay:Number = 0;
			var McIssuesGitPh:MovieClip = new MovieClip();
			var McPhAdded:MovieClip = McMain.mcPhbase.mcPhIssues.addChild(McIssuesGitPh);
			
			McPhAdded.name = "PhGitIssues";
			McPhAdded.y = McMain.mcPhbase.mcPhIssues.height;
			
			
			var OItemHeaderClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("IssueItemHeader") as Class;
			var MoItemHeader:MovieClip = new OItemHeaderClass() as MovieClip;
			MoItemHeader.visible = true;
			
			
			var McItemHeader:MovieClip = MovieClip(McPhAdded.addChild(MoItemHeader));
			McItemHeader.mcTitle.txtFoundGit.text = OSWAuditCurrentSession.ArrGitIssues.length + " issues from Git NOT found in JIRA version " + OSWAuditCurrentSession.Key;
			McItemHeader.y = InitY;
			McItemHeader.name = "mcHeader";
			McItemHeader.mcTitle.mouseEnabled = true;
			McItemHeader.mcTitle.mouseChildren = false;
			McItemHeader.mcTitle.buttomMode = true;
			McItemHeader.mcTitle.addEventListener(MouseEvent.CLICK , OnClickHeader);
			
			InitY += McItemHeader.height;
			
			
			for (var i:uint = 0; i < OSWAuditCurrentSession.ArrGitIssues.length;i++ )
			{
				var OItemClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("IssueItemGit") as Class;
				var MoItem:MovieClip = new OItemClass() as MovieClip;
				MoItem.visible = true;
				
				var McItem:MovieClip = MovieClip(McPhAdded.addChild(MoItem));
				
				McItem.y = InitY;
				
				McItem.alpha = 0;
				Tweener.addTween(McItem, {alpha:1, time:.3, delay:Delay,transition:"linear"});
				
				Delay +=.01;

				var fixversion:Array = new Array();
				
				
				if (OSWAuditCurrentSession.ArrGitIssues[i].fixVersions != null)
				{
					var fv:Object = OSWAuditCurrentSession.ArrGitIssues[i].fixVersions;
					
					for (var ob:Object in fv)
					{
						if (fv[ob]["name"] != undefined)
						{
							fixversion.push(fv[ob]["name"]);
						}
						
					}
				}
				
				
				McItem.name = OSWAuditCurrentSession.ArrGitIssues[i].key;
				McItem.txtInc.text = i+1;
				McItem.txtKey.text = OSWAuditCurrentSession.ArrGitIssues[i].key;
				McItem.txtSummary.text = OSWAuditCurrentSession.ArrGitIssues[i].summary;
				McItem.txtFixVersions.text = fixversion;
				
				McItem.type = OSWAuditCurrentSession.ArrGitIssues[i]["type"].name;
				McItem.status = OSWAuditCurrentSession.ArrGitIssues[i].status;
				McItem.mcIconType.gotoAndStop(OSWAuditCurrentSession.ArrGitIssues[i]["type"].name);
				
				McItem.cacheAsBitmap = true;
				
				McItem.mouseEnabled = true;
				McItem.mouseChildren = false
				McItem.buttonMode = true;
				McItem.addEventListener(MouseEvent.CLICK, PopulateSWItem)

				InitY += McItem.height;
				
				McItem.mcStatus.gotoAndStop(String(OSWAuditCurrentSession.ArrGitIssues[i]["status"].name).toLowerCase());
				
				CreateIssueStatusList(String(OSWAuditCurrentSession.ArrGitIssues[i]["status"].name));
				
			
				
			}
			
			McMain.spIssues.source = McMain.mcPhbase.mcPhIssues;
			
			UpdateIssuesListFromGit();
		}
		
		private function OnClickHeader(e:MouseEvent):void
		{
			var ArrayIssues:Array = new Array();
			
			for (var i:int = 0; i < OSWAuditCurrentSession.ArrGitIssues.length; i++) 
			{
				ArrayIssues.push(OSWAuditCurrentSession.ArrGitIssues[i].key);
			}
			
			
			
			var JiraLink:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("jirahost" , "urls") + ArrayIssues[0] + "?jql=issuekey%20in%20(" + ArrayIssues + ")");
			navigateToURL(JiraLink, "_blank");
		}
		
		private function ShowGitNotFound(e:MouseEvent):void
		{
			
			var JiraLink:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("jirahost" , "urls") + e.currentTarget.parent.ArrNotFound.split(",")[0] + "?jql=issuekey%20in%20(" + e.currentTarget.parent.ArrNotFound + ")");
			navigateToURL(JiraLink, "_blank");
		}

		
		private function UpdateIssuesList():void
		{
			
			Log.Print(">>>>> JIRAxGIT UpdateIssuesList Called ");
			
			OSWAuditCurrentSession.GitHead.NumFoundInVersion = 0;
			if(OSWAuditCurrentSession.GitRC != null)OSWAuditCurrentSession.GitRC.NumFoundInVersion   = 0;
			
			
			for (var i:uint = 0 ; i < McMain.mcPhbase.mcPhIssues.numChildren;i++ )
			{
				var issueItem:MovieClip = McMain.mcPhbase.mcPhIssues.getChildAt(i);

				
				if (issueItem.name == "PhGitIssues") continue;
				
				var xGit:uint = 0;
				
				for (var j:uint = 0; j <  OSWAuditCurrentSession.ArrReleaseNotes.length; j++ )
				{		
					var OItemClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("mcgitinfo") as Class;
					var MoItem:MovieClip = new OItemClass() as MovieClip;
					MoItem.visible = true;
					
					
					MoItem.name =  String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Version) + j;
				
					
					
					var McItem:MovieClip = issueItem.mcPhGitInfo.addChild(MoItem);
					McItem.x = McMain.mcGitInfo.mcPhnotes.getChildAt(j).x + (McMain.mcGitInfo.mcPhnotes.getChildAt(j).txtLabel.textWidth/2);
					
				
					for (var z:uint = 0; z <  GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).ArrCommits.length; z++ )
					{
						
						if (issueItem.name == GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).ArrCommits[z].JiraKey)
						{
							MoItem.gotoAndStop("FOUND");
						}
						else
						{	
							if (String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Name).toLowerCase().indexOf("x.x") != -1 || String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Version.replace("V","")) == String(OSWAuditCurrentSession.Version.replace(" ","")))
							{
								if(MoItem.currentFrame==1)MoItem.gotoAndStop("NOTFOUND");
							}
						}
					}
					
					if (OSWAuditCurrentSession.GitRC != null)
					{
					
						if (String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Version.replace("V","")) == OSWAuditCurrentSession.GitRC.Version)
						{
							if(OSWAuditCurrentSession.ArrTagReleaseNotes !=null){
							
								for (var h:int = 0; h < OSWAuditCurrentSession.ArrTagReleaseNotes.length; h++) 
								{
									var OItemClassRC:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("mcgitinfoRC") as Class;
									var MoItemRC:MovieClip = new OItemClassRC() as MovieClip;
									MoItemRC.visible = true;
									MoItemRC.name =  String(GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[h]).Name) + h;
								
									var McItemRC:MovieClip = issueItem.mcPhGitInfo.addChild(MoItemRC);
									McItemRC.x = McMain.mcGitInfo.mcPhnotes.getChildAt(j).x+ McMain.mcGitInfo.mcPhnotes.getChildAt(j).mcRCPh.x + McMain.mcGitInfo.mcPhnotes.getChildAt(j).mcRCPh.getChildAt(h).x;
									
									
									for (var t:uint = 0; t <  GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[h]).ArrCommits.length; t++ )
									{
										
										if (issueItem.name == GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[h]).ArrCommits[t].JiraKey)
										{
											
											MoItemRC.gotoAndStop("FOUND");
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		private function UpdateIssuesListFromGit():void
		{
			
			Log.Print(">>>>> JIRAxGIT UpdateIssuesList Called ");
			
			var McPh:MovieClip = MovieClip(McMain.mcPhbase.mcPhIssues.getChildByName("PhGitIssues"));
			
		
			for (var i:uint = 0 ; i < McPh.numChildren;i++ )
			{
				var issueItem:MovieClip = MovieClip(McPh.getChildAt(i));
					
				if (issueItem.name == "mcHeader")continue;
				
				for (var j:uint = 0; j <  OSWAuditCurrentSession.ArrReleaseNotes.length; j++ )
				{
								
					var OItemClass:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("mcgitinfo") as Class;
					var MoItem:MovieClip = new OItemClass() as MovieClip;
					MoItem.visible = true;
					MoItem.name =  String(OSWAuditCurrentSession.ArrReleaseNotes[j].Version) + j;
				
					
					var McItem:MovieClip = issueItem.mcPhGitInfo.addChild(MoItem);
					//McItem.x = McMain.mcGitInfo.mcPhnotes.getChildAt(j).x;
					McItem.x = McMain.mcGitInfo.mcPhnotes.getChildAt(j).x + (McMain.mcGitInfo.mcPhnotes.getChildAt(j).txtLabel.textWidth/2);
					
					issueItem.txtFixVersions.x = issueItem.mcPhGitInfo.x + issueItem.mcPhGitInfo.width + 50;
					
					for (var z:uint = 0; z <  GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).ArrCommits.length; z++ )
					{
						
						if (issueItem.name == GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).ArrCommits[z].JiraKey)
						{
							
							MoItem.gotoAndStop("FOUND");
						}
						else
						{	
							if (String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Name).toLowerCase().indexOf("x.x") != -1 || String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Version.replace("V","")) == String(OSWAuditCurrentSession.Version.replace(" ","")))
							{
								//if(MoItem.currentFrame==1)MoItem.gotoAndStop("NOTFOUND");
							}
						}
					}
					
					if (OSWAuditCurrentSession.GitRC != null)
					{
					
						if (String(GitReleaseNotes(OSWAuditCurrentSession.ArrReleaseNotes[j]).Version.replace("V","")) == OSWAuditCurrentSession.GitRC.Version)
						{
							
							
							if(OSWAuditCurrentSession.ArrTagReleaseNotes !=null){
							
								for (var h:int = 0; h < OSWAuditCurrentSession.ArrTagReleaseNotes.length; h++) 
								{
									var OItemClassRC:Class = loaderInfo.contentLoaderInfo.applicationDomain.getDefinition("mcgitinfoRC") as Class;
									var MoItemRC:MovieClip = new OItemClassRC() as MovieClip;
									MoItemRC.visible = true;
									MoItemRC.name =  String(GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[h]).Name) + h;
								
									var McItemRC:MovieClip = issueItem.mcPhGitInfo.addChild(MoItemRC);
									McItemRC.x = McMain.mcGitInfo.mcPhnotes.getChildAt(j).x+ McMain.mcGitInfo.mcPhnotes.getChildAt(j).mcRCPh.x + McMain.mcGitInfo.mcPhnotes.getChildAt(j).mcRCPh.getChildAt(h).x;
									
									
									for (var t:uint = 0; t <  GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[h]).ArrCommits.length; t++ )
									{
										
										if (issueItem.name == GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[h]).ArrCommits[t].JiraKey)
										{
											
											MoItemRC.gotoAndStop("FOUND");
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
	
		
		private function CheckDuplicated(Arr:Array , Str:String , field:String = "" , field2:String = ""):Boolean
		{
			for (var i:uint = 0; i < Arr.length;i++)
			{
				
				if (field == "" && field2 =="")
				{
					

					if (Str == Arr[i])
					{
						
						return true;
					}
				}
				else if(field != "" && field2 =="")
				{
					
					if (String(Str) == String(Arr[i][field]))
					{
						return true;
					}
				}
				else
				{
				
					if (Str == Arr[i][field][field2])
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function ShowHideReleaseNotes(show:Boolean , Delay:Number=0, showSuggested:Boolean = false , fnc:Function = null , hash_include:String = "", hash_exclude:String = "" , hash_label:String ="" , callback:Function = null):void
		{
			
			Log.Print(">>>>> GIT : ShowHideReleaseNotes Called ");
			Log.Print(">>>>>>>>> ShowHideReleaseNotes : Show  : " + show);
			Log.Print(">>>>>>>>> ShowHideReleaseNotes : Fnc   : " + fnc);
			Log.Print(">>>>>>>>> ShowHideReleaseNotes : Label : " + hash_label);
			Log.Print(">>>>>>>>> ShowHideReleaseNotes : Call  : " + callback);
			
			if (show)
			{
				McMain.mcAddReleaseForm.mouseChildren = true;
				
				McMain.mcBlockBg.mouseEnabled = true;
				Tweener.addTween(McMain.mcBlockBg, {alpha:.65, time:.3, delay:Delay,transition:"Linear"});
				
				McMain.mcGitInfo.mcMais.play();
				Tweener.addTween(McMain.mcAddReleaseForm, {x:1200, time:.5, delay:Delay, transition:"EaseInOut", onComplete: function():void{McMain.mcAddReleaseForm.x=1200; }});
				Tweener.addTween(McMain.mcAddReleaseForm, {alpha:1, time:.5, delay:Delay, transition:"EaseInOut"});
				
				if (showSuggested)
				{
					McMain.mcAddReleaseForm.mcSuggestion.alpha = 1;
					McMain.mcAddReleaseForm.mcSuggestion.visible = true;
				}
				else
				{
					McMain.mcAddReleaseForm.mcSuggestion.alpha = 0;
					McMain.mcAddReleaseForm.mcSuggestion.visible = false;
				}
			}
			else if (McMain.mcGitInfo.mcMais.currentFrame == McMain.mcGitInfo.mcMais.totalFrames)
			{
				McMain.mcAddReleaseForm.mouseChildren = false;
				
				McMain.mcBlockBg.mouseEnabled = false;
				Tweener.addTween(McMain.mcBlockBg, {alpha:0, time:.3, delay:Delay,transition:"Linear"});
				
				McMain.mcGitInfo.mcMais.play();
				Tweener.addTween(McMain.mcAddReleaseForm, {x:1750, time:.6, delay:Delay, transition:"EaseOutIn", onComplete: function():void
				{
					McMain.mcAddReleaseForm.x=1750;
					if (fnc != null)
					{
						fnc(hash_include , hash_exclude , hash_label , callback);
					}
				}});
				Tweener.addTween(McMain.mcAddReleaseForm, {alpha:0, time:.5, delay:Delay,transition:"EaseOutIn"});
			}
		}
		
		private function OnClickAddGit(e:MouseEvent):void
		{
			
			if (McMain.mcGitInfo.mcMais.currentFrame == 1 )
			{
				ShowHideReleaseNotes(true);				
			}
			else if (McMain.mcGitInfo.mcMais.currentFrame == McMain.mcGitInfo.mcMais.totalFrames)
			{
				ShowHideReleaseNotes(false);
			}
			
		}
		
		
		
		private function BitBucketGetCommitsList(includeHash:String , excludeHash:String , hash_label:String , callBackFunction:Function):void
		{
			Log.Print(">>>>> GIT : BitBucketGetCommitsList Called");
			Log.Print(">>>>>>>>> BitBucketGetCommitsList : Label   :" + hash_label);
			Log.Print(">>>>>>>>> BitBucketGetCommitsList : Load h1 : " + includeHash);
			Log.Print(">>>>>>>>> BitBucketGetCommitsList : Load h2 : " + excludeHash);
			Log.Print(">>>>>>>>> BitBucketGetCommitsList : Call    : " + callBackFunction);
			Log.Print("-----------------------")
			
			this.addEventListener(CommitsEvent.COMPLETE , callBackFunction );
			
			var urlReq:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("bitbucket_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")) + "bitbucket-commits.php?since=" + excludeHash + "&until=" + includeHash + "&r=" + Math.random());
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, function(e:Event):void {  dispatchEvent(new CommitsEvent(CommitsEvent.COMPLETE , hash_label , e.target.data));});
            loader.addEventListener(IOErrorEvent.IO_ERROR, OnErrorBitbucketCommitList);
            loader.load(urlReq);
		}
		
		private function OnErrorBitbucketCommitList(e:IOErrorEvent):void
		{
			trace("Bitbucket OAuth Failed : " + e.text);
			
			ShowDialog(true , "Bitbucket OAuth Failed!" , e.text);
			
			McMain.mcAddReleaseForm.txtFeedbackRn.text = e.text;
			
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
		}
		
		private function OnLoadBitbucketCommitList(e:CommitsEvent):void
		{
			Log.Print(">>>>> GIT : OnLoadBitbucketCommitList Called");
			
			this.removeEventListener(CommitsEvent.COMPLETE , OnLoadBitbucketCommitList );
			
			PreParseBitbucketCommitList(e);
		}
		
		private function PreParseBitbucketCommitList( e:CommitsEvent ):void
        {
			Log.Print(">>>>> GIT : PreParseBitbucketCommitList Called");

			
			var strMessages:String = "";
			
			if ( e.HashData )
            {
				
				
				var obj:Object = new Object()
				obj = JSON.parse(String(e.HashData));
				
				if (obj["error_description"] == undefined)
				{
									
					if (obj["values"] != undefined)
					{
						obj = obj["values"];
						for (var ob:Object in obj)
						{
							if(obj[ob]["message"]!= undefined)
							{
								strMessages += obj[ob]["message"];
							}
						}
						ParseCSV(JSON.stringify(e.HashData), e.HashLabel,false);
						
					}
				}
				else
				{
					ShowDialog(true , "Error loading Bitbucket Commits!" ,  obj["error"]);
					
					trace("Error loading Bitbucket Commits : " + obj["error"]);
					Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
				}
            }
        }
		
	
		
		private function CheckSuggestedBranches():void
		{
			Log.Print(">>>>> GIT : CheckSuggestedBranches Called");
			
			Navigation.McLoading.alpha=0;
			Navigation.McLoading.visible=true;
			Tweener.addTween(Navigation.McLoading, {alpha:1, time:.3, transition:"linear" , onComplete: SuggestedBranches});
		}
		
		private function SuggestedBranches():void
		{
		
			Log.Print(">>>>> GIT : SuggestedBranches Called");
			
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
		}
		
		private var arrSuggestionCalls:Array;
		
		private function onClickAddCompare(e:MouseEvent):void
		{
			AddCompareReleaseNotes(true);
		}
		
	
		
		private function AddCompareReleaseNotes(clicked:Boolean):void
		{
			Log.Print(">>>>> GENERAL : AddCompareReleaseNotes Called ("+clicked+")");
			
			
			arrSuggestionCalls = new Array();
			
			if (McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text !="" && String(McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text).length > 0)
			{
				Log.Print(">>>>>>>>> AddCompareReleaseNotes IF");
				
				Navigation.McLoading.alpha=0;
				Navigation.McLoading.visible=true;
				Tweener.addTween(Navigation.McLoading, {alpha:1, time:.3, transition:"linear"});
				
				
				if (OSWAuditCurrentSession.GitRC != null)
				{
					arrSuggestionCalls.push({hash_include: OSWAuditCurrentSession.GitRC.LatestcommitHash , hash_exclude: McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text , hash_label:"V"+OSWAuditCurrentSession.GitRC.Version })
				}
				
				arrSuggestionCalls.push({hash_include: McMain.mcAddReleaseForm.mcSuggestion.txtBranchPrevHash.text , hash_exclude: McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text , hash_label:"V"+String(McMain.mcAddReleaseForm.mcSuggestion.txtBranchPrev.text).split("_V")[1] })
				
				if (clicked)
				{
					ShowHideReleaseNotes( false , .5, false , BitBucketGetCommitsList , McMain.mcAddReleaseForm.mcSuggestion.txtBranchHeadHash.text, McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text , "V"+String(McMain.mcAddReleaseForm.mcSuggestion.txtBranchHead.text).split("_V")[1],OnLoadBitbucketCommitList );
				}
				else
				{
					BitBucketGetCommitsList(McMain.mcAddReleaseForm.mcSuggestion.txtBranchHeadHash.text, McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text , "V"+String(McMain.mcAddReleaseForm.mcSuggestion.txtBranchHead.text).split("_V")[1], OnLoadBitbucketCommitList );
				}
			}
			else{
				Log.Print(">>>>>>>>> AddCompareReleaseNotes ELSE");
			}
			
			
		}
		
		
		//RCs
		
		private function BitBucketGetTags(filterText:String = ""):void
		{
			Log.Print(">>>>> GIT : BitBucketGetTags Called (" + filterText + ")");
			
			var urlReq:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("bitbucket_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")) + "bitbucket-tags.php?limit=150&filterText=" + filterText + "&r=" + Math.random());
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, OnLoadBitbucketTags);
            loader.addEventListener(IOErrorEvent.IO_ERROR, OnErrorBitbucketTags);
            loader.load(urlReq);
		}
		
		private function OnErrorBitbucketTags(e:IOErrorEvent):void
		{
			trace("Bitbucket Tags Failed : " + e.text);
			
			ShowDialog(true , "Bitbucket Tags Failed!" , e.text);
						
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
		}
		
		private function OnLoadBitbucketTags(e:Event):void
		{
			
			Log.Print(">>>>> GIT : OnLoadBitbucketTags Called");
			
			var ArrTags:Array = new Array();
			
			
			var obj:Object = new Object();

			obj = JSON.parse(String(e.target.data));
			
			if (obj["error_description"] == undefined)
			{
								
				if (obj["values"] != undefined)
				{
					obj = obj["values"];
					for (var ob:Object in obj)
					{
						if(obj[ob]["displayId"]!= undefined)
						{
									
							var OGitBranch:GitBranch = new GitBranch();
							OGitBranch.Name             = obj[ob]["id"];
							OGitBranch.Type             = obj[ob]["type"];
							OGitBranch.Key              = String(obj[ob]["displayId"]);
							OGitBranch.Version          = String(obj[ob]["displayId"]).split("_")[2]; // Get V11.0.0 from APP_1_V11.0.0_RC1
							OGitBranch.LatestcommitHash = obj[ob]["latestCommit"];
							
							ArrTags.push(OGitBranch);
						}
					}
					
					ArrTags.sortOn("Key" , Array.DESCENDING);
			
					if (ArrTags.length > 0)
					{
						if (OSWAuditCurrentSession.GitRC != null)
						{
							OSWAuditCurrentSession.GitRC.ArrGitTags = new Array();
							OSWAuditCurrentSession.GitRC.ArrGitTags = ArrTags;
							
							OSWAuditCurrentSession.ArrTagReleaseNotes = new Array();
							
							numRCFound = 0;
							
							GetReleaseNotesForRCTags();
						}
					}
					else{
							CreateReleaseNotesLabelMenu();
					}
				}
			}
			else
			{
				trace("Error loading Bitbucket Tags : " + obj["error"]);
				ShowDialog(true , "Error loading Bitbucket Tags!" , obj["error"]);
				Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
			}
		}
		
		private var numRCFound:uint;
		
		private function GetReleaseNotesForRCTags():void
		{
			Log.Print(">>>>> GIT : GetReleaseNotesForRCTags Called");
			
				//trace("GetReleaseNotesForRCTags")
			
			if (numRCFound < OSWAuditCurrentSession.GitRC.ArrGitTags.length)
			{
				//trace("GetReleaseNotesForRCTags if - call BitBucketGetCommitsList")
				
				var strRClabel:String = GitBranch(OSWAuditCurrentSession.GitRC.ArrGitTags[numRCFound]).Key.split("_")[3]; //Get RC1 from APP_1_V11.5.0_RC1
				
				BitBucketGetCommitsList(GitBranch(OSWAuditCurrentSession.GitRC.ArrGitTags[numRCFound]).LatestcommitHash, OSWAuditCurrentSession.HashMergebase , strRClabel, OnLoadBitbucketTagCommitList );
			
				numRCFound++;
			}
			else
			{
				//trace("Len " , GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[0]).Name)
				//trace("Len " , GitReleaseNotes(OSWAuditCurrentSession.ArrTagReleaseNotes[1]).Name)
				
				CreateReleaseNotesLabelMenu();
			}
		}
		
		private function OnLoadBitbucketTagCommitList(e:CommitsEvent):void
		{
			Log.Print(">>>>> GIT : OnLoadBitbucketTagCommitList Called");
			
			this.removeEventListener(CommitsEvent.COMPLETE , OnLoadBitbucketTagCommitList );
			
			PreParseBitbucketTagCommitList(e.HashData , e.HashLabel);
		}
		
		private function PreParseBitbucketTagCommitList( HashData:Object , HashLabel:String ):void
        {
			Log.Print(">>>>> GIT : PreParseBitbucketTagCommitList Called");
			
			var strMessages:String = "";
			
			
			if ( HashData )
            {
				
				
				var obj:Object = new Object()
				obj = JSON.parse(String(HashData));
				
				if (obj["error_description"] == undefined)
				{
									
					if (obj["values"] != undefined)
					{
						obj = obj["values"];
						for (var ob:Object in obj)
						{
							if(obj[ob]["message"]!= undefined)
							{
								strMessages += obj[ob]["message"];
							}
						}
						ParseCSV(JSON.stringify(HashData), HashLabel,false);
						
					}
				}
				else
				{
					ShowDialog(true , "Error loading Bitbucket Tag Commits!" ,obj["error"]);
					trace("Error loading Bitbucket Tag Commits : " + obj["error"]);
					Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
				}
            }
        }
		
		
		//branches
		
		
		private function BitBucketGetBranches(filterText:String = ""):void
		{
			Log.Print(">>>>> GIT : BitBucketGetBranches Called (" + filterText + ")");
			
			var urlReq:URLRequest = new URLRequest(SiteFacade.Instance.OModel.GetValue("bitbucket_url_api" , "urls" , SiteFacade.Instance.OModel.GetValue("enviroment")) + "bitbucket-branches.php?limit=150&filterText=" + filterText + "&r=" + Math.random());
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, OnLoadBitbucketBranches);
            loader.addEventListener(IOErrorEvent.IO_ERROR, OnErrorBitbucketBranches);
            loader.load(urlReq);
		}
		
		private function OnErrorBitbucketBranches(e:IOErrorEvent):void
		{
			trace("Bitbucket Branches Failed : " + e.text);
			
			ShowDialog(true , "Bitbucket Branches Failed!" , e.text);
						
			Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
		}
		
		private function OnLoadBitbucketBranches(e:Event):void
		{
			
			var ArrBranches:Array = new Array();
			
			OSWAuditCurrentSession.ArrGitBranches = new Array();
			
			if ( e.target.data )
            {
				Log.Print(">>>>> GIT : OnLoadBitbucketBranches Called");
				
				
				var obj:Object = new Object();

				obj = JSON.parse(String(e.target.data));
				
				
				
				if (obj["size"] > 0)
				{
									
					if (obj["values"] != undefined)
					{
						obj = obj["values"];
						for (var ob:Object in obj)
						{
							if(obj[ob]["displayId"]!= undefined)
							{
								var Str:String = obj[ob]["displayId"].split("_V")[1];
								
								if (Str.split(".")[2] == null || Str.split(".")[0] > OSWAuditCurrentSession.Version.split(".")[0]) continue; //in case of bad naming convention as 10.2000
								
								if (Str.split(".")[2].length <= 2)
								{
									if (Str.toLowerCase().indexOf(".x.x") != -1)
									{
										Log.Print(">>>>>>>>> OnLoadBitbucketBranches : X.X.X found");									
										
										var OGitBranchHead:GitBranch = new GitBranch();
										OGitBranchHead.Name             = obj[ob]["displayId"];
										OGitBranchHead.Key              = String(obj[ob]["displayId"]).split("/")[1];
										OGitBranchHead.Version          = Str;
										OGitBranchHead.LatestcommitHash = obj[ob]["latestCommit"];
										
										OSWAuditCurrentSession.GitHead  = OGitBranchHead;
									}
									else
									{
										if (String(Str.split(".")[2]).toLowerCase() != "x")
										{											
											if (String(Str) != OSWAuditCurrentSession.Key.split("_V")[1].replace(" ",""))
											{
												Log.Print(">>>>>>>>> OnLoadBitbucketBranches : branch added");
												
												var OGitBranch:GitBranch = new GitBranch();
												OGitBranch.Name             = obj[ob]["displayId"];
												OGitBranch.Key              = String(obj[ob]["displayId"]).split("/")[1];
												OGitBranch.Version          = Str;
												OGitBranch.LatestcommitHash = obj[ob]["latestCommit"];
												
												var ArrDigits:Array  = Str.split(".");
												var strDigits:String = "";
												
												for (var i:int = 0; i < ArrDigits.length ; i++) 
												{
													
													if (String(ArrDigits[i]).length == 1)
													{
														strDigits += "0" + String(ArrDigits[i])
													}
													else
													{
														strDigits += String(ArrDigits[i])
													}
													if(i < ArrDigits.length-1) strDigits += ".";
												}
												
												OGitBranch.VersionOrderBy = strDigits;
												
												ArrBranches.push(OGitBranch);
											}
											else
											{
												Log.Print(">>>>>>>>> OnLoadBitbucketBranches : RC branch added");
												
												var OGitBranchRC:GitBranch = new GitBranch();
												OGitBranchRC.Name             = obj[ob]["displayId"];
												OGitBranchRC.Key              = String(obj[ob]["displayId"]).split("/")[1];
												OGitBranchRC.Version          = Str;
												OGitBranchRC.LatestcommitHash = obj[ob]["latestCommit"];
												
												var ArrDigitsRC:Array  = Str.split(".");
												var strDigitsRC:String = "";
												
												for (var q:int = 0; q < ArrDigitsRC.length ; q++) 
												{
													
													if (String(ArrDigitsRC[i]).length == 1)
													{
														strDigitsRC += "0" + String(ArrDigitsRC[i])
													}
													else
													{
														strDigitsRC += String(ArrDigitsRC[i])
													}
													if(i < ArrDigitsRC.length-1) strDigitsRC += ".";
												}
												
												OGitBranchRC.VersionOrderBy = strDigitsRC;
											}
										}
									}
								}
							}
						}
											
					}
					
					ArrBranches.sortOn("VersionOrderBy");
			
					OSWAuditCurrentSession.ArrGitBranches = new Array();
					OSWAuditCurrentSession.ArrGitBranches = ArrBranches;
					
					
					if (OGitBranchRC != null) OSWAuditCurrentSession.GitRC = OGitBranchRC;
					
					
					BitBucketGetCommitsList(OSWAuditCurrentSession.GitHead.LatestcommitHash , GitBranch(OSWAuditCurrentSession.ArrGitBranches[OSWAuditCurrentSession.ArrGitBranches.length - 1]).LatestcommitHash, "" , FindMergeBase);
				}
				else
				{
					ShowDialog(true , "Bitbucket: Branches" ,"No Branches found for this value!" );
					//trace("Error loading Bitbucket Branches : " + obj["error"]);
					Tweener.addTween(Navigation.McLoading, {alpha:0, time:.3, transition:"linear" , onComplete: function():void{Navigation.McLoading.visible = false; }});
				}
			}
			
		
		}
		
		private function FindMergeBase(e:CommitsEvent):void
		{
			
			this.removeEventListener(CommitsEvent.COMPLETE , FindMergeBase );
			
			Log.Print(">>>>> GIT : FindMergeBase Called");
			
			var ArrBranchesForMergeBase:Array = new Array();
			
			if ( e.HashData )
            { 
				var obj:Object = new Object()
				obj = JSON.parse(String(e.HashData));
				
				if (obj["error_description"] == undefined)
				{
					if (obj["values"] != undefined)
					{
						obj = obj["values"];
						for (var ob:Object in obj)
						{
							if (obj[ob]["parents"] == null) continue;
													
							ArrBranchesForMergeBase.push({parenthash:obj[ob]["parents"][0]["id"] , timestamp:obj[ob]["authorTimestamp"] })
						}
					}
				}
				else
				{
					ShowDialog(true , "Not able to find MergeBase!" , obj["error"]);
				}
			
			
				Log.Print(">>>>>>>>> FindMergeBase : ArrBranchesForMergeBase.length : " + ArrBranchesForMergeBase.length)
			
				
				fillSuggestion(OSWAuditCurrentSession.GitHead , GitBranch(OSWAuditCurrentSession.ArrGitBranches[OSWAuditCurrentSession.ArrGitBranches.length - 1]), ArrBranchesForMergeBase[ArrBranchesForMergeBase.length - 1]["parenthash"]);
				
				
				//TODO
				//BitBucketGetTags(OSWAuditCurrentSession.Key);
			}
		}
		
		private function fillSuggestion(head:GitBranch , prevRelease:GitBranch , mergebase:String):void
		{
			
			Log.Print(">>>>> GIT : fillSuggestion Called");
			Log.Print(">>>>>>>>> fillSuggestion : head.Key        : " + head.Key);
			Log.Print(">>>>>>>>> fillSuggestion : prevRelease.Key : " + prevRelease.Key);
			Log.Print(">>>>>>>>> fillSuggestion : mergebase       : " + mergebase);

			OSWAuditCurrentSession.HashMergebase = mergebase;
			
			McMain.mcAddReleaseForm.mcSuggestion.txtBranchHead.text     = head.Key;
			McMain.mcAddReleaseForm.mcSuggestion.txtBranchHeadHash.text = head.LatestcommitHash;
			
			McMain.mcAddReleaseForm.mcSuggestion.txtBranchPrev.text     = prevRelease.Key;
			McMain.mcAddReleaseForm.mcSuggestion.txtBranchPrevHash.text = prevRelease.LatestcommitHash;
			
			McMain.mcAddReleaseForm.mcSuggestion.txtInputMergebase.text = mergebase;
		}
		
			
		private var fnc1:Function;
		private var fnc2:Function;
		
		private function ShowDialog(show:Boolean , title:String = "" , msg:String = "" , optFnc1:Function = null , optFnc2:Function = null):void
		{
		
			
			McMain.mcDialog.mcConfirm.visible = false;
			McMain.mcDialog.mcClose.visible   = false;
			McMain.mcDialog.mcCancel.visible  = false;
				
			
			if (show)
			{
				McMain.mcDialog.visible         = true;
				McMain.mcBlockBg.visible        = true;
				
				if(fnc1 != null)McMain.mcDialog.mcConfirm.removeEventListener(MouseEvent.CLICK , fnc1);
				if(fnc2 != null)McMain.mcDialog.mcCancel.removeEventListener(MouseEvent.CLICK , fnc2);
				
				
				fnc1 = optFnc1;
				fnc2 = optFnc2;
				
				McMain.mcDialog.txtTitle.text = title;
				McMain.mcDialog.txtMsg.autoSize = TextFieldAutoSize.CENTER;
				McMain.mcDialog.txtMsg.text   = msg;
				

				
				Tweener.addTween(McMain.mcDialog, {alpha:1, time:.3,transition:"linear"});
				Tweener.addTween(McMain.mcBlockBg, {alpha:.8, time:.3, transition:"linear"});
				
				
				if (optFnc1 != null && optFnc2 != null)
				{
					McMain.mcDialog.mcConfirm.visible = true;
					McMain.mcDialog.mcConfirm.addEventListener(MouseEvent.CLICK , optFnc1);
					
					McMain.mcDialog.mcCancel.visible = true;
					McMain.mcDialog.mcCancel.addEventListener(MouseEvent.CLICK , optFnc2);
				}
				else{
					
					
					McMain.mcDialog.mcClose.visible = true;
					
				}
			}
			else{
				Tweener.addTween(McMain.mcDialog, {alpha:0, time:.3, transition:"linear" , onComplete:function():void {McMain.mcDialog.visible = false; }});
				Tweener.addTween(McMain.mcBlockBg, {alpha:0, time:.3,transition:"linear" , onComplete:function():void {McMain.mcBlockBg.visible = false; }});
			}
		}
	}
}