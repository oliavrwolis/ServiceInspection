/* Copyright (c) 2020 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

Include Ensemble

Class XunJian.Page.DetailPage Extends %ZEN.Component.page
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
    <script src="../user/echarts.min.js"></script>
   <script type="text/javascript">
	     
	     

	 </script>
 <div style="margin-top:50px">
      <div style=" margin: auto;width:1080px;display:flex">
      <div style="width:70%">
      
       
        </div>
        <div style="width:30%;float:right">
      
       </div>
      </div>
      <div style="height:360px">
        <table class="gridtable" style=" width:1080px;margin: auto;">
        <tbody>
            >
             if (%request.Get("Item") ="Queue")
             {
	             &html<
	             <tr>
              <th onclick="">NAME</th>
              <th>NUM</th>
            
            
              
	             
	             >
	            SET ARR=..getCurrenQueue()
	             FOR i=0:1:ARR.%Size()-1{
	             set BSNAME=ARR.%Get(i).%Get("BSNAME")
	             set Num=ARR.%Get(i).%Get("Num")
               &html<
          
	                <tr>
		             <td onclick="zenPage.getQueue('#(BSNAME)#')">#(BSNAME)# </td>
		             <td >#(Num)#</td>
		            </tr>
              >
             }  
	          }elseif %request.Get("Item") ="MsgNum" {
		          
		          &html<
	             <tr>
              <th onclick="">NAME</th>
              <th>NUM</th>   
	             >
		       set ARR=..getMsgNum()  
		       FOR i=0:1:ARR.%Size()-1{
	             set BSNAME=ARR.%Get(i).%Get("BSNAME")
	             set Num=ARR.%Get(i).%Get("Num")
               &html<
          
	                <tr>
		             <td onclick="zenPage.getMsgNumList('#(BSNAME)#')">#(BSNAME)# </td>
		             <td >#(Num)#</td>
		            </tr>
              >
             } 
		       
		         }
             else {
		          
		          &html<
	             <tr>
              <th onclick="">BSNAME</th>
              <th>Idletime</th>   
              <th>LastTime</th>   
	             >
		       set ARR=..getinactivity()  
		       FOR i=0:1:ARR.%Size()-1{
	             set BSNAME=ARR.%Get(i).%Get("BSNAME")
	             set LastTime=ARR.%Get(i).%Get("LastTime")
	              set Idletime=ARR.%Get(i).%Get("Idletime")
               &html<
          
	                <tr>
		             <td >#(BSNAME)# </td>
		             <td >#(LastTime)#</td>
		              <td >#(Idletime)#</td>
		            </tr>
              >
             } 
		       
		         }
            
          &html<
            </tbody>
        </table>
       
      </div>
      <div style=" margin: auto;width:1080px;"> 
      <div id="main" style="width: 600px;height:400px;"></div>
      <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        setTimeout(function(){
	       if ( window.location.search=="?Item=Queue"){
		       
		     zenPage.getQueue("")
	       
	       
	       }else if(window.location.search=="?Item=MsgNum"){
		       zenPage.getMsgNumList("")
		      }
	    },1000);
   </script>
    </div>
    
  </body>

</html>
	
	 >
	
 	   Quit $$$OK
}

ClientMethod getQueue(BSNAME) [ Language = javascript ]
{
	var str=this.doGetQueueList(BSNAME)
	
	var arr=  eval('(' + str + ')')
	console.log(arr.timearr)
	 var myChart = echarts.init(document.getElementById('main'));
 
        // 指定图表的配置项和数据
        var option = option = {
  xAxis: {
    type: 'category',
    data: arr.timearr,
  },
  yAxis: {
    type: 'value'
  },
   tooltip: {
    trigger: 'axis'
  },
  series: [
    {
      data:arr.numarr,
      type: 'line',
      smooth: true
    }
  ]
};
 
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
}

ClassMethod doGetQueueList(BSNAME) As %String [ ZenMethod ]
{
   set arr=##class(XunJian.Tasks.Util).GetQueueList(BSNAME)
   Quit arr.%ToJSON()
}

ClassMethod getCurrenQueue()
{
	set result=[]
	Set sqlStr="call Ens.Queue_Enumerate()"
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sqlStr)
    set DateTime1=$zdt($h,3)
    if qStatus'=1 {}
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	    set temp={}
	    
        set temp.BSNAME=rset.%Get("Name")
        set temp.Num=rset.%Get("Count")
        Do result.%Push(temp)
    }
	Quit result
}

ClassMethod getinactivity()
{
	set result=[]
	
	Set sqlStr="select * from XunJian_Tasks.inactivityMSG "
   
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sqlStr)
    set DateTime1=$zdt($h,3)
    if qStatus'=1 {}
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	    set temp={}
	    
        set temp.BSNAME=rset.%Get("BSNAME")
        set temp.LastTime=rset.%Get("LastTime")
        set temp.Idletime=rset.%Get("Idletime")
        
        Do result.%Push(temp)
    }
   
	Quit result
}

ClassMethod getMsgNum()
{
	set result=[]
	set date=$p($zdt($h,3),":",1)_":00:00"
	Set sqlStr="select sum(MsgNum) as MsgNum,BSNAME from XunJian_Tasks.MessageNumMSG where  DateTime1 > '"_date_"' group by BSNAME "
   
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sqlStr)
    set DateTime1=$zdt($h,3)
    if qStatus'=1 {}
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	    set temp={}
	    
        set temp.BSNAME=rset.%Get("BSNAME")
        set temp.Num=rset.%Get("MsgNum")
        Do result.%Push(temp)
    }
    SET ^TEST=result.%ToJSON()
	Quit result
}

ClassMethod doGetMsgNumList(BSNAME) As %String [ ZenMethod ]
{
   set timearr=[]
   set numarr=[]
   IF (BSNAME=""){
    set sqlStr="select sum(MsgNum) as MsgNum,DateTime1 from XunJian_Tasks.MessageNumMSG group by DateTime1 "
   }ELSE{
	set sqlStr="select sum(MsgNum) as MsgNum,DateTime1 from XunJian_Tasks.MessageNumMSG WHERE BSNAME ='"_BSNAME_"' group by DateTime1 "   
	  }
   Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sqlStr)
    set DateTime1=$zdt($h,3)
    if qStatus'=1 {}
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	  
	    
         Do timearr.%Push(rset.%Get("DateTime1"))
         Do numarr.%Push(rset.%Get("MsgNum"))
    }
	set result={}
	set result.timearr=timearr
	set result.numarr=numarr
	
	Quit result.%ToJSON()
}

ClientMethod getMsgNumList(BSNAME) [ Language = javascript ]
{
	var str=this.doGetMsgNumList(BSNAME)
	
	var arr=  eval('(' + str + ')')
	console.log(arr.timearr)
	 var myChart = echarts.init(document.getElementById('main'));
 
        // 指定图表的配置项和数据
        var option  = {
  xAxis: {
    type: 'category',
    data: arr.timearr,
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data:arr.numarr,
      type: 'line',
      smooth: true
    }
  ]
};
 
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
}

}

