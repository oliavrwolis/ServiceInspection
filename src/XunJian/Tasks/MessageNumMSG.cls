Class XunJian.Tasks.MessageNumMSG Extends %Persistent
{

Property DateTime1 As %String;

Property BSNAME As %String;

Property MsgNum As %Numeric;

Storage Default
{
<Data name="MessageNumMSGDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DateTime1</Value>
</Value>
<Value name="3">
<Value>BSNAME</Value>
</Value>
<Value name="4">
<Value>QueueNum</Value>
</Value>
<Value name="5">
<Value>MsgNum</Value>
</Value>
</Data>
<DataLocation>^XunJian.Tasks.MessageNumMSGD</DataLocation>
<DefaultData>MessageNumMSGDefaultData</DefaultData>
<ExtentSize>3</ExtentSize>
<IdLocation>^XunJian.Tasks.MessageNumMSGD</IdLocation>
<IndexLocation>^XunJian.Tasks.MessageNumMSGI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="BSNAME">
<AverageFieldSize>19.33</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="DateTime1">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2024-12-11 06:00:00"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="MsgNum">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^XunJian.Tasks.MessageNumMSGS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

