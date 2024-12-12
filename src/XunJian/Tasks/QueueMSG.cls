Class XunJian.Tasks.QueueMSG Extends %Persistent
{

Property DateTime1 As %String;

Property BSNAME As %String;

Property QueueNum As %String;

Storage Default
{
<Data name="QueueMSGDefaultData">
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
</Data>
<DataLocation>^XunJian.Tasks.QueueMSGD</DataLocation>
<DefaultData>QueueMSGDefaultData</DefaultData>
<ExtentSize>11</ExtentSize>
<IdLocation>^XunJian.Tasks.QueueMSGD</IdLocation>
<IndexLocation>^XunJian.Tasks.QueueMSGI</IndexLocation>
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
<AverageFieldSize>17.18</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="DateTime1">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="QueueNum">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:0</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^XunJian.Tasks.QueueMSGS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

