/* Copyright (c) 2020 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

Include Ensemble

Class XunJian.Page.SettingPage Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "XunJian.Tasks.Application";

/// Displayed name of this page.
Parameter PAGENAME;

/// Domain used for localization.
Parameter DOMAIN;

XData CSS3Style
{
}

XData Style
{
}

XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="SSSS">
<html id="description"  OnDrawContent="DrawDescription"/>
</page>
}

Method DrawDescription(pSeed As %String) As %Status
{

	
	&html<
	  <html style="width:1400px;height:800px">
	   <head>
    <!-- Put your page Title here -->
    <title>Settingpage</title>
  </head>
  <!-- CSS goes in the document HEAD or added to your external stylesheet -->
  <style type="text/css">table.gridtable { font-family: verdana,arial,sans-serif; font-size:22px; color:#333333; border-width: 1px; border-color: #666666; border-collapse: collapse; } table.gridtable th { 
    background: rgba(64,158,255,.1);
    padding: 0;
    height: 44px;
    line-height: 44px;
    font-size: 14px;
    color: #409eff;
    border: none;
    position: relative;
    font-family: SourceHanSansCN;
    font-weight: 400;
   } table.gridtable td { 
   max-width:700px;
   font-size: 14px;
   border-bottom: 1px solid #ebeef5;
    padding: 12px 0;
    min-width: 0;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    text-overflow: ellipsis;
    vertical-align: middle;
    position: relative;
    text-align: center;
    } .button { 
    display: inline-block;
    line-height: 1;
    white-space: nowrap;
    cursor: pointer;
    background: #fff;
    border: 1px solid #dcdfe6;
    color: #606266;
    -webkit-appearance: none;
    text-align: center;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    outline: 0;
    margin: 0;
    -webkit-transition: .1s;
    transition: .1s;
    font-weight: 500;
    padding: 12px 20px;
    font-size: 14px;
    border-radius: 4px;
    background-color: #409eff!important;
    color: #fff;
    border-top-left-radius: 0!important;
    border-bottom-left-radius: 0!important;
 } 
    .input{
	height: 32px;
    color: #646970;
    font-size: 14px;
    font-family: SourceHanSansCN;
    font-weight: 400;
    border: 1px solid #dbdbdb;
    border-radius: 4px;   
	    
	 }
	 .select{
	     height: 32px;
    color: #646970;
    font-size: 14px;
    font-family: SourceHanSansCN;
    font-weight: 400;
    border: 1px solid #dbdbdb;
    border-radius: 4px;   
	    
	 }
	 .switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input {
    display:none;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
    </style>
  
  <body>
   <script type="text/javascript">
	    
	    function datechange() {
		   
		    var obj = document.getElementById('dateselect'); 
		    var index = obj.selectedIndex; 
            var value = obj.options[index].value; 
            window.location.href="#(%request.URL)#"+"?date="+value;
         
    }

	 </script>
 <div style="margin-top:50px">
      <div style=" margin: auto;width:1080px;display:flex">
      <div style="width:70%">
      
      
        </div>
        <div style="width:30%;float:right">
      
       </div>
      </div>
      <div style="">
        <table class="gridtable" style=" width:1080px;margin: auto;">
        <tbody>
            <tr>
              <th>item</th>
              <th>threshold</th>
              <th>Enable</th>
            
              >  set ARR=##CLASS(XunJian.Tasks.Util).GetAllSetting()
              SET length=ARR.%Size()
              set i=1
              for i=0:1:length-1
              {
            
               &html<
		            <tr>
		             <td align="right">#(ARR.%Get(i).name)# </td>
		             <td ><input #(ARR.%Get(i).ifthreshold)#  type="number" id="#(ARR.%Get(i).name)#threshold" name="threshold" value="#(ARR.%Get(i).threshold)#" />    </td>
		             <td >
		             <label class="switch">
  <input id="#(ARR.%Get(i).name)#Enable" name="Enablef"  type="checkbox" #(ARR.%Get(i).Enable)# #(ARR.%Get(i).ifEnabled)# >
  <div class="slider round"></div>
</label>
		              </td>
                   </tr>
                  >}  
               &html<
          
            </tbody>
        </table>
       
      </div>
      <div style=" margin: auto;width:1080px;"> 
     
       <!--<label> 这里放告警对接邮箱地址/or短信接口地址</label><input id=""></input>-->
      
     
     
    </div>
     <div style=" margin: auto;width:1080px;"> 
     
     
      <div style="float:right"><button onclick="zenPage.SaveSetting()">保存</button></div></div>
     
     
    </div>
  </body>

</html>
	
	 >
	
 	   Quit $$$OK
}

ClientMethod SaveSetting() [ Language = javascript ]
{
	var threshold = document.getElementsByName("threshold");
	var Enabled=document.getElementsByName("Enablef");
	var r=[]
	console.log(Enabled)
		for(var i =0;i<threshold.length;i++){
		    var temp={}
		    temp.name=threshold[i].id
		    temp.threshold=threshold[i].value
		    temp.Enabled=Enabled[i].checked
			r.push(temp)
		}
		console.log(r)
		this.doSaveSetting(JSON.stringify(r))
}

ClassMethod doSaveSetting(input) As %String [ ZenMethod ]
{
	
	set ar=[].%FromJSON(input)

    for i=0:1:ar.%Size()-1
	{
		set temp=$replace(ar.%Get(i).name,"threshold","")
	   set ^ServiceInspection(temp,"threshold")=ar.%Get(i).threshold
	   set enabled=""
	 
	   if (ar.%Get(i).Enabled'=0){
	   set enabled="checked"
	   }
	   set ^ServiceInspection(temp,"Enable")=enabled
	 
	
	}
	Quit $$$OK
	///保存到global里
}

}

