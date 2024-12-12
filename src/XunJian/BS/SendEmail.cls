Class XunJian.BS.SendEmail Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, pOutput As %RegisteredObject) As %Status
{
	
	Set tSC=..SendRequestAsync("EnsLib.EMail.AlertOperation",pInput)
}

}

