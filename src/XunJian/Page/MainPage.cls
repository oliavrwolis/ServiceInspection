/* Copyright (c) 2020 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

Include Ensemble

Class XunJian.Page.MainPage Extends %CSP.Page
{

/// Output the default login page as HTML
ClassMethod OnPage() As %Status
{
	Set %Status = ..OninPage()
	Quit $$$OK
}

ClassMethod OninPage() As %Status
{
	try {
		set date=%request.Data("date",1)
		
	}catch e{
		 set date=""		
	}
	   set URL="http://localhost:52773"
	
	&html<
	  <html style="width:1400px;height:800px">
	   <head>
    <!-- Put your page Title here -->
    <title>mainpage</title>
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
    text-align: left;
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
        <label id="timelabel" style=" margin: auto;">Time： </label>
        <select id="dateselect" class="select" onchange="datechange()" >
         #(##class(XunJian.Tasks.Util).getDate(date))#
        </select>
      
        </div>
        <div style="width:30%;float:right">
        <a id="downloada" style="float:right;padding:9px 15px;" href='#(##class(XunJian.Tasks.Util).GetUrl(date))#' download="result.pdf">down</a>
      
       </div>
      </div>
      <div style="">
        <table class="gridtable" style=" width:1080px;margin: auto;">
        <tbody>
            <tr>
              <th>item</th>
              <th>server</th>
              <th>content</th>
              <th>result</th>
              >
              
              ////循环获取每一个 暂时先用磁盘空间的
              set ARR=##class(%DynamicArray).%New()
              if (date'="")&&(date'="Curren")
              {
	             &sql(select GetDisk,GetCpu,GetMem,GetMessageLog,GetLicenseInfo,GetTasksStatus,GetQueue
	              into :GetDisk,:GetCpu,:GetMem,:GetMessageLog,:GetLicenseInfo,:GetTasksStatus,:GetQueue from XunJian_Tasks.MSG where Date1=:date)    
	              SET GetDisk={}.%FromJSON(GetDisk)
	              SET GetCpu={}.%FromJSON(GetCpu)
	              SET GetMem={}.%FromJSON(GetMem)
	              SET GetMessageLog={}.%FromJSON(GetMessageLog)
	              SET GetLicenseInfo={}.%FromJSON(GetLicenseInfo)
	              SET GetTasksStatus={}.%FromJSON(GetTasksStatus)
	              SET GetQueue={}.%FromJSON(GetQueue)
	              Do ARR.%Push(GetDisk)
	              Do ARR.%Push(GetCpu)
	              Do ARR.%Push(GetMem)
	              Do ARR.%Push(GetMessageLog)
	              Do ARR.%Push(GetLicenseInfo)
	              Do ARR.%Push(GetTasksStatus)
	              Do ARR.%Push(GetQueue)
	            
	            //w ARR.%ToJSON(),!
	           Do ##CLASS(XunJian.Tasks.Util).downloadpdf(ARR,date)
	           
	          }else{
		         
		          set CURRENdate=$zdt($h,3)
		         
                  set ARR=##CLASS(XunJian.Tasks.Util).GetAll(.CURRENdate)
                  set date1=CURRENdate
                      &html< <script type="text/javascript">
           document.getElementById ("downloada").setAttribute ("href","#(##class(XunJian.Tasks.Util).GetUrl(date1))#");
            </script>>
              }
       
              SET length=ARR.%Size()
              set i=1
              for i=0:1:length-1
              {
	            
			       &html<
		            <tr>
		             <td >#(ARR.%Get(i).name)# </td>
                    <td>curren</td>
                    <td title="#(ARR.%Get(i).title)#"> >
                  
                   if (ARR.%Get(i).href'="")
                   {
	               &html<
                      <a href="#(URL_ARR.%Get(i).href)#" target="_blank">
                        #(ARR.%Get(i).DataT.content)#
                      </a>>
	               }else{
		               &html<
                        #(ARR.%Get(i).DataT.content)#
                       >
		           }
                   &html<</td>
                  
                   >
                   if ARR.%Get(i).DataT.flag=1{
	               &html<<td style="text-align:center"><svg STYLE="color:green" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
                      <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z" />
                      </svg>
                   </td>>
	               }else{ 
		            &html< <td style="text-align:center"><svg STYLE="color:red" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                     <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z" />
                     </svg></td>
                     </tr>
                     >
		            }   
			     
	          }
             &html< 
            </tbody>
        </table>
      </div>
    
    </div>
  </body>

</html>
	
	 >
	
 	   Quit $$$OK
}

}

