Class XunJian.Tasks.Util Extends EnsPortal.Utils
{

ClassMethod GetAll(ByRef date) As %DynamicArray
{
	
	set all=##class(%DynamicArray).%New()
	set disk=..GetDisk()
	Do all.%Push(disk)
	Do all.%Push(..GetCpu())
	Do all.%Push(..GetMem())
	Do all.%Push(..GetMessageLog())
	Do all.%Push(..GetLicenseInfo())
	Do all.%Push(..GetTasksStatus())
	Do all.%Push(..GetQueue())
    Do all.%Push(..GetInactivity())
     Do all.%Push(..GetTrafficPerHour())
	Do ..downloadpdf(all,date)

	Quit all
}

ClassMethod GetTrafficPerHour() As %DynamicArray
{
	set re={}
	set re.name="Traffic Per Hour"
	set re.server="1"
	set data=[]
	set content=""
	SET DataT={}
	set flag=1
	set content=""
    set num=0
     SET WDate=$p($system.SQL.DATEADD("H",1,$zdt($h,3)),":",1)_":00:00"
	set sql="Select count(1) as num from XunJian_Tasks.MessageNumMSG where MsgNum>'"_^ServiceInspection("traffic per hour","threshold")_"' and  DateTime1>='"_WDate_"'"
	set ^ttt=sql
	Set statement = ##class(%SQL.Statement).%New()
	Set qStatus = statement.%Prepare(sql)
	Set rset = statement.%Execute()
	while rset.%Next(){	
	        set num=rset.%Get("num")
	}
	if num>0{
		set flag=0
		set content="<text style=""color:red"">There are components with a message volume greater than "_^ServiceInspection("traffic per hour","threshold")_"</text><br>"
	}
   
    SET NUM=0
   
   
  
    set DataT.data=[]
    set DataT.flag=flag
    set DataT.content=content
    set re.DataT=DataT
	set re.flag=flag
	
	set re.href="/user/XunJian.Page.DetailPage.cls?Item=MsgNum"
	Quit re
}

ClassMethod GetAllSetting() As %DynamicArray
{
	///初始数据
	set ItemList=[{"name":"disk","value":"60","ifthreshold":"","ifEnabled":"disabled"},
	{"name":"cpu","value":"60","ifthreshold":"","ifEnabled":"disabled"},
	{"name":"Memory","value":"60","ifthreshold":"","ifEnabled":"disabled"},
	{"name":"MessageLog","value":"-","ifthreshold":"disabled","ifEnabled":"disabled"}
	,{"name":"LicenseInfo","value":"-","ifthreshold":"disabled","ifEnabled":"disabled"},
	{"name":"TasksStatus","value":"-","ifthreshold":"disabled","ifEnabled":"disabled"},
	{"name":"Queue","value":"60","ifthreshold":"","ifEnabled":""},
	{"name":"inactivity","value":"6000","ifthreshold":"","ifEnabled":""}
	,{"name":"traffic per hour","value":"60000","ifthreshold":"","ifEnabled":""}
	
	]
	set all=[]

   for i=0:1:ItemList.%Size()-1
   {
   try {
	set Item={}
    set Item.name=ItemList.%Get(i).name
    set Item.threshold=^ServiceInspection(Item.name,"threshold")
    set Item.Enable=^ServiceInspection(Item.name,"Enable")
   }catch e{
	set ^ServiceInspection(ItemList.%Get(i).name,"threshold")=ItemList.%Get(i).value
    set ^ServiceInspection(ItemList.%Get(i).name,"Enable")=""
	set Item.threshold=^ServiceInspection(Item.name,"threshold")
    set Item.Enable=^ServiceInspection(Item.name,"Enable")
    }
    //w "---",!
    set Item.ifthreshold=ItemList.%Get(i).ifthreshold
     set Item.ifEnabled=ItemList.%Get(i).ifEnabled
    Do all.%Push(Item)
   }

    

	Quit all
}

ClassMethod GetQueueList(BSNAME) As %DynamicArray
{
    set timearr=[]
	set numarr=[]
		
	IF BSNAME=""
	{
		
		
		
		Set sqlStr="SELECT  sum(QueueNum) as num,DateTime1 FROM XunJian_Tasks.QueueMSG  GROUP BY DateTime1 "}
		ELSE{
				Set sqlStr="SELECT  QueueNum as num,DateTime1 FROM XunJian_Tasks.QueueMSG  WHERE BSNAME ='"_BSNAME_"' "
		}
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sqlStr)
  
   
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	   
       Do timearr.%Push(rset.%Get("DateTime1"))
       Do numarr.%Push(rset.%Get("num"))
      }
	
		
	
	set result={}
	set result.timearr=timearr
	set result.numarr=numarr
	Quit result
}

ClassMethod GetUrl(name) As %String
{
	if (name="")||(name="Curren"){set name=$zd($h,3)}
	Quit "http://"_$p($zu(54,13,$zu(54,0)),",",1)_":52773/csp/user/result"_name_".pdf"
}

ClassMethod GetCpu() As %DynamicObject
{
    	set re={}
	    set re.name="cpu usage"
	    set re.server="1"
	    set data=[]
    	set data=[]
    	set DataT={}
    	
    	set cpuuse=..GetCpuUse()
    	
    
	    set flag=1
	 set DataT.data=data
	 if (cpuuse>^ServiceInspection("cpu","threshold")){
		 set DataT.content="<text style=""color:red"">"_"cpu usage rate is "_cpuuse_"</text>"
		 
		set flag=0 
		}else{
	 set DataT.content="cpu usage rate is "_cpuuse
	 }
	 set DataT.flag=flag
	 set re.flag=flag
	 SET re.href=""
	 set re.DataT=DataT
	 Quit re
}

ClassMethod GetDisk() As %DynamicObject
{
    	set re={}
	    set re.name="Disk Information"
	    set re.server="1"
	    set data=[]
    	set data=[]
    	set DataT={}
    	set flag=1
    	set diskInfo=..GetDisk1()
    	set diskArr=[].%FromJSON(diskInfo)
    	set i=0
    	set Content=""
    
    	for i=0:1:diskArr.%Size()-1
    	{
	    	set Name=diskArr.%Get(i).%Get("mount_pointer")
	    	set Use=diskArr.%Get(i).%Get("percent")
	    	if (Use>^ServiceInspection("disk","threshold"))
	    	{
		      set flage=0	
		        set Content=Content_"<text style=""color:red"">"_Name_" Remaining "_diskArr.%Get(i)."free"_" kb,The usage rate is "_Use_"%;"_"</text><br>" 
			   
		    }else{
			   set Content=Content_Name_" Remaining "_diskArr.%Get(i)."free"_" kb,The usage rate is "_Use_"%;<br>" 
			   }
	     set temp={}
			 set temp.name=Name
			 //set temp.name=a1.Name
			 Do data.%Push(temp)
	    	
	    }
	    
	 set DataT.data=data
	 set DataT.content=Content
	 set DataT.flag=1
	 set re.flag=1
	 SET re.href=""
	 set re.DataT=DataT
	 Quit re
}

ClassMethod downloadpdf(all, name)
{
	set i=0
	set title=["item","content","result"]
	set table=[]
	Do table.%Push(title)
	for i=0:1:all.%Size()-1
	{
	  	set temp=[]
	  	Do temp.%Push(all.%Get(i).%Get("name"))
	  	Do temp.%Push(all.%Get(i).%Get("DataT").%Get("content"))
	  	if (all.%Get(i).%Get("DataT").%Get("flag")=1){
	  	Do temp.%Push("√")
	  	}else{
		  	Do temp.%Push("×")
		 }
	  	Do table.%Push(temp)
	  	//Do temp.%Push(all.%Get(i).%Get("DataT").%Get("flag"))
	}
	Do ..createpdf($replace(table.%ToJSON(),"<br>",""),"result"_name_".pdf")
}

ClassMethod createpdf(datajson, name) [ Language = python ]
{



from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import LongTable, TableStyle, BaseDocTemplate,Frame, PageTemplate
from reportlab.lib import colors
from reportlab.platypus import Paragraph, Table, TableStyle
import json
data= json.loads(datajson)
def reprFrame(frame):
    _dict = vars(frame)


def test():
    doc = BaseDocTemplate(
        "/usr/irissys/csp/user/"+name,
        pagesize=A4,
        rightMargin=72,
        leftMargin=72,
        topMargin=50,
        bottomMargin=80,
        showBoundary=False)

    elements = []
   


    tableStyle = [
        ('INNERGRID', (0, 0), (-1, -1), 0.25, colors.black),
        ('BOX', (0, 0), (-1, -1), 0.25, colors.black),
        ]


    styles = getSampleStyleSheet()
    styleN = styles['Normal']

    styleN.wordWrap = 'CJK'
    data2 = [[Paragraph(cell, styleN) for cell in row] for row in data]

    frame = Frame(doc.leftMargin, doc.bottomMargin, doc.width, doc.height - 2 , id='normal')

    reprFrame(frame)

    colwidths = [frame._width/5. for i in range(5)]

    t = LongTable(data2, colWidths=colwidths)
    t.setStyle(TableStyle(tableStyle))
    elements.append(t)

    template = PageTemplate(id='longtable', frames=frame)
    doc.addPageTemplates([template])
    doc.build(elements)
test()
}

ClassMethod GetCpuUse() [ Language = python ]
{
import psutil
import datetime
from xlrd import open_workbook
from xlutils.copy import copy
import time
cpu = psutil.cpu_count(False)    # cpu核数 默认逻辑CPU核数， False查看真实cpu核数 2
cpu_per = int(psutil.cpu_percent(1))  
#print(cpu_per)
return cpu_per
}

ClassMethod GetDisk1() [ Language = python ]
{
import psutil
import json
all=[]
hd = {}
for id in psutil.disk_partitions():
        disk_info = psutil.disk_usage(id.mountpoint)
        hd['mount_pointer'] = id.mountpoint
        hd['total'] = int(disk_info.total / 1024)
        hd['used'] = int(disk_info.used / 1024)
        hd['free'] = int(disk_info.free / 1024)
        hd['percent'] = disk_info.percent
        all.append(hd)
       #print(hd)
return json.dumps(all, indent=2)
}

ClassMethod GetMem() As %DynamicObject
{
	
    	set re={}
	    set re.name="Memory Information"
	    set re.server="1"
	    set data=[]
    	set data=[]
    	set DataT={}
    	set MemInfo=..GetMemInfo()
    	set MemkOb={}.%FromJSON(MemInfo)
    	set i=0
    	set Content=""
     set flag=1
	 set DataT.data=data
	 if (MemkOb.%Get("mem_per")>^ServiceInspection("Memory","threshold")){
		  set DataT.content="<text style=""color:red"">"_"Memory usage rate:"_MemkOb.%Get("mem_per")_"%"_"</text>"
		 set flag=0
		 
		 }else{
	 set DataT.content="Memory usage rate:"_MemkOb.%Get("mem_per")_"%"
	 }
	 set DataT.flag=flag
	 set re.flag=flag
	 SET re.href=""
	 set re.DataT=DataT
	 Quit re
}

ClassMethod GetMemInfo() [ Language = python ]
{
 import psutil	
 import json
 mem = psutil.virtual_memory()  
 mem_total = int(mem[0]/1024/1024)
 mem_used = int(mem[3]/1024/1024)
 mem_per = int(mem[2])
 mem_info = {
        'mem_total': mem_total,
        'mem_used': mem_used,
        'mem_per': mem_per,
 }
 return  json.dumps(mem_info, indent=2)
}

ClassMethod GetQueue() As %DynamicObject
{
	set re={}
	set re.name="Queuing"
	set re.server="1"
	set data=[]
	set total=0
	set content=""
	SET DataT={}
	set flag=1
	set name=""
	set name=$o(^|"USER"|Ens.Queue(name))
	while (name'=""){
	    set name=$o(^|"USER"|Ens.Queue(name))
	   
	    IF (name'=""){
		    if ^|"USER"|Ens.Queue(name,0,"count")'=0
		    {
			   set temp={}
		       set temp.name=name
		        set temp.value=^|"USER"|Ens.Queue(name,0,"count")
		        Do data.%Push(temp)
		        set flag=0
		        set total=total+^|"USER"|Ens.Queue(name,0,"count")
		        set content=content_name_","
		      // w name,!
			   //w ^|"JHDQS"|Ens.Queue(name,0,"count"),!
			}
	      // w ^|"JHDQS"|Ens.Queue(name,0,"count"),!
	    }
	    
	}
	set DataT={}
	if (content'="")
	{
	  set content=content_"There is a queue"	
	  	
	}else{set content="Currently no queue"}
	 set DataT.data=data
	 set DataT.flag=flag
	 set DataT.content=content
	 set re.flag=flag
	 set re.DataT=DataT
	 set re.total=total
	 set re.href="/user/XunJian.Page.DetailPage.cls?Item=Queue"
	 //w re.%ToJSON()
	Quit re
}

ClassMethod GetInactivity() As %DynamicObject
{
	set re={}
	set re.name="Inactivity"
	set re.server="1"
	set data=[]
	set content=""
	SET DataT={}
	set flag=1
	set content=""
    set num=0
	set sql="Select count(1) as num from XunJian_Tasks.inactivityMSG where Idletime>'"_^ServiceInspection("inactivity","threshold")_"'"
	Set statement = ##class(%SQL.Statement).%New()
	Set qStatus = statement.%Prepare(sql)
	Set rset = statement.%Execute()
	while rset.%Next(){	
	        set num=rset.%Get("num")
	}
	if num>0{
		set flag=0
		set content="<text style=""color:red"">Component inactive for more than "_^ServiceInspection("inactivity","threshold")_" seconds</text><br>"
	}
   
    SET NUM=0
   
   
  
    set DataT.data=[]
    set DataT.flag=flag
    set DataT.content=content
    set re.DataT=DataT
	set re.flag=flag
	
	set re.href="/user/XunJian.Page.DetailPage.cls?Item=inactive"
	Quit re
}

ClassMethod GetMessageLog() As %DynamicObject
{
	set re={}
	set re.name="console log"
	set re.server="1"
	set data=[]
	set content="No errors in the system logs within seven days"
	SET DataT={}
	set flag=1
	Set stream1=##class(%FileCharacterStream).%New()
    if ($l($zv,"UNIX")>1){
	      set stream1.Filename=$System.Util.InstallDirectory()_"/mgr/alerts.log"
	}ELSE{
		  set stream1.Filename=$System.Util.InstallDirectory()_"\mgr\alerts.log"
	}
	set n1=0
    set n2=0
	set resultArray=##class(%DynamicArray).%New()
	WHILE ('stream1.AtEnd) {      
        
        
           set strr=stream1.ReadLine() 
       
          set date=$p($system.SQL.DATEADD("D",-7,$ZDT($H,3))," ",1)
          set date2=$p($p(strr,"-",1),"/",1,2)_"/20"_$p($p(strr,"-",1),"/",3)
          
          if ($system.SQL.DATEDIFF("DAY",date,date2)>=0){
          set flag=0
          set content="<text style=""color:red"">There are errors in the logs of the system within seven days</text>" 
          }
    }
    //w content,!
    set result1=##class(%DynamicObject).%New()
	set result1.ErrorNum=n2
	set result1.AlertNum=n1
	//倒序
	set newArray=##class(%DynamicArray).%New()
	set l=resultArray.%Size()
	set i=1
	for i=1:1:l{
	    Do newArray.%Push(resultArray.%Pop())
    }
	set result1.Info=newArray
    set DataT.data=[]
    set DataT.flag=flag
    set DataT.content=content
	set re.flag=flag
	SET re.href="/sys/op/UtilSysConsoleLog.csp"
	set re.DataT=DataT
	 
	Quit re
}

ClassMethod GetTasksStatus() As %DynamicObject
{
	set re={}
	set re.name="Scheduled task inspection"
	set re.server="1"
	set data=[]
	set content=""
	SET DataT={}
	set flag=1
	set content1=""
	set content2=""

	set sql="SELECT  Name,Status,Suspended   FROM %SYS.Task where Status!=1 or Suspended!=0"
	Set statement = ##class(%SQL.Statement).%New()
	Set qStatus = statement.%Prepare(sql)
	Set rset = statement.%Execute()
	while rset.%Next(){	
	        Set name=rset.%Get("Name")
	        Set Status=rset.%Get("Status")
	        Set Suspended=rset.%Get("Suspended")
	        if (Status'=1){
		            set flag=0
		        set content1=content1_name_","
		    }
		   // w name_","_Suspended,!
		    if (Suspended'="0")
		    {   
		        set flag=0
			    set content2=content2_name_","
			 }
			 set name=""
		   //	Set name = rset.%Get("Name")
	}
    if content1'="" set content1="<text style=""color:red"">"_$e(content1,1,*-1)_"</text>Task execution error<br>"
    if content2'="" set content2="<text style=""color:red"">"_$e(content2,1,*-1)_"</text>Task Pending<br>"
    set content=content1_content2
    SET NUM=0
   
   
    if content="" {set content="The task has no abnormalities"}
    set DataT.data=[]
    set DataT.flag=flag
    set DataT.content=content
    set re.DataT=DataT
	set re.flag=flag
	
	set re.href="/sys/op/%25CSP.UI.Portal.TaskSchedule.zen"
	Quit re
	///定时任务删除也在这
}

ClassMethod GetLicenseInfo() As %DynamicObject
{
	
	set DataA={}
    set DataB={}
    set data=[]
    set flag=1
	set content=""
	Set outstr=""
	Set pOutput=##class(Ens.StringResponse).%New()
    Set Rset=##class(%ResultSet).%New("%SYSTEM.License.Summary")
	if 'Rset Set status="Could not form query %SYSTEM.License.Summary." w !,status q
	Set r=Rset.Execute()
	if r {
		 		Set ncol=Rset.GetColumnCount()
	 			for i=1:1:ncol s headings(i)=Rset.GetColumnName(i)
	 			Set nrec=0
	 			While (Rset.Next()) {
	 			Set nrec=nrec+1
	  			Set ncol=Rset.GetColumnCount()
	  			for i=1:1:ncol Set data(nrec,i)=Rset.GetData(i)
	}
	Do Rset.Close()
	Set status=nrec_" entries added to array"
	}
    set cutten= (data(1,2)/data(3,2))*100
    set max=(data(2,2)/data(3,2))*100
    if ($P(cutten,".",1)=""){set cutten=0_cutten}
    if ($P(max,".",1)=""){set max=0_max}
    set content="Current license usage rate:"_cutten_"%;Maximum License Usage:"_max_"%"
    set re={}
    set data={}
    set data.Max=max
    set data.Curren=cutten
    set DataA.data=data
    set DataA.content=content
    set DataA.flag=flag
   
	
    set re.flag=flag
    set re.server=1
    set re.name="License"
   set re.DataT=DataA
    set re.href="/sys/%25CSP.UI.Portal.EnsembleMonitor.zen"
	Quit re
}

ClassMethod getDate(date) As %String
{
	
	set str=""
    set sql="SELECT Date1 FROM XunJian_Tasks.MSG"
	Set statement = ##class(%SQL.Statement).%New()
	Set qStatus = statement.%Prepare(sql)
	if (qStatus=1){
	  Set tResult = statement.%Execute()
	  while tResult.%Next(){
		  if (date'="")&&(date=tResult.%Get("Date1")){
		      set str=str_"<option selected>"_tResult.%Get("Date1")_"</option>"
		  }else{
			  set str=str_"<option>"_tResult.%Get("Date1")_"</option>"
		  }
	  }
	}
	set str=	"<option>Curren</option>"_str
	Quit str
}

ClassMethod CreateTask() As %String
{

	set Time="00:30:00"
	set Name="XunjianTask"
	//日期$h
	Set taskObj=##class(%SYS.Task).%New()
	Set taskObj.Name=Name
	Set taskObj.NameSpace="User"
	Set taskObj.Description=Name
	Set taskObj.TaskClass="XunJian.Tasks.Task"
	Set taskObj.DisplayRun="Daily, every day"
	Set taskObj.TimePeriod="0"
	Set taskObj.TimePeriodDay=""
	Set taskObj.TimePeriodEvery=1
	Set taskObj.DailyFrequency=0
	Set taskObj.DailyFrequencyTime=0
	Set taskObj.DailyIncrement=""
	set time=($p(Time,":",1)*60*60)+($p(Time,":",2)*60)+($p(Time,":",3))
	Set taskObj.DailyStartTime=time
	Set taskObj.DisplayStartDate=$zd($h,3)
	//Set taskObj.StartDate=$zd($h,3)
		set taskObj.RunAsUser="_SYSTEM"
	
	S tsc=taskObj.%Save()

	
	
	
	
	
	
	
	set Time="00:00:00"
	set Name="QueueTask"
	//日期$h
	Set taskObj=##class(%SYS.Task).%New()
	Set taskObj.Name=Name
	Set taskObj.NameSpace="User"
	Set taskObj.Description=Name
	Set taskObj.TaskClass="XunJian.Tasks.QueueTask"
	Set taskObj.DisplayRun="Daily, every day"
	Set taskObj.TimePeriod="0"
	Set taskObj.TimePeriodDay=""
	Set taskObj.TimePeriodEvery=1
	Set taskObj.DailyFrequency=0
	Set taskObj.DailyFrequencyTime=0
	Set taskObj.DailyIncrement="1"
	set time=($p(Time,":",1)*60*60)+($p(Time,":",2)*60)+($p(Time,":",3))
	Set taskObj.DailyStartTime=time
	Set taskObj.DisplayStartDate=$zd($h,3)
	//Set taskObj.StartDate=$zd($h,3)
		set taskObj.RunAsUser="_SYSTEM"
	
	S tsc=taskObj.%Save()
	
	set Time="00:00:00"
	set Name="XJMsgTask"
	//日期$h
	Set taskObj=##class(%SYS.Task).%New()
	Set taskObj.Name=Name
	Set taskObj.NameSpace="User"
	Set taskObj.Description=Name
	Set taskObj.TaskClass="XunJian.Tasks.MsgTask"
	Set taskObj.DisplayRun="Daily, every day"
	Set taskObj.TimePeriod="0"
	Set taskObj.TimePeriodDay=""
	Set taskObj.TimePeriodEvery=1
	Set taskObj.DailyFrequency=0
	Set taskObj.DailyFrequencyTime=0
	Set taskObj.DailyIncrement=10
	set time=($p(Time,":",1)*60*60)+($p(Time,":",2)*60)+($p(Time,":",3))
	Set taskObj.DailyStartTime=time
	Set taskObj.DisplayStartDate=$zd($h,3)
	//Set taskObj.StartDate=$zd($h,3)
		set taskObj.RunAsUser="_SYSTEM"
	
	S tsc=taskObj.%Save()
	
		set Time="00:00:00"
	set Name="inactivityTask"
	//日期$h
	Set taskObj=##class(%SYS.Task).%New()
	Set taskObj.Name=Name
	Set taskObj.NameSpace="User"
	Set taskObj.Description=Name
	Set taskObj.TaskClass="XunJian.Tasks.inactivityTask"
	Set taskObj.DisplayRun="Daily, every day"
	Set taskObj.TimePeriod="0"
	Set taskObj.TimePeriodDay=""
	Set taskObj.TimePeriodEvery=1
	Set taskObj.DailyFrequency=0
	Set taskObj.DailyFrequencyTime=0
	Set taskObj.DailyIncrement="10"
	set time=($p(Time,":",1)*60*60)+($p(Time,":",2)*60)+($p(Time,":",3))
	Set taskObj.DailyStartTime=time
	Set taskObj.DisplayStartDate=$zd($h,3)
	//Set taskObj.StartDate=$zd($h,3)
		set taskObj.RunAsUser="_SYSTEM"
	
	S tsc=taskObj.%Save()
	

	
	Quit $$$OK
}

}

