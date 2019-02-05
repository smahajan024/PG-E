public with sharing class NRD_AmendedProcessController {
     @AuraEnabled
     public static String cloneAmendedOpportunity(String objectId,String processValue){
     	
     	String Message = '';
     	Opportunity objOpportunity = [SELECT Name,AccountId,StageName,CloseDate,RecordTypeId FROM Opportunity WHERE id=:objectId];
     	Opportunity objAmendOpportunity = objOpportunity.clone(false,false,false,false);
        objAmendOpportunity.Name = 'Amend Opportunity - '+objOpportunity.Name;
        objAmendOpportunity.NRD_Amend_Opportunity__c = objectId;
        objAmendOpportunity.Type = processValue;
        try{
        		insert objAmendOpportunity;
        		Message = 'record saved successfully !!!!';
        	}Catch(Exception e){
        		system.debug('Exception due to ----->'+e.getMessage()+e.getLineNumber());
        		Message = 'Exception ';
        	}

        	return Message;
        }

        @AuraEnabled
        public static String cloneAmendedContract(String opportunityId){
        	String Message = '';
        	Opportunity objOpportunity = [SELECT id,NRD_Amend_Opportunity__c,RecordType.DeveloperName FROM Opportunity WHERE id=:opportunityId];
        	String recordTypeName = objOpportunity.RecordType.DeveloperName;
        	Contract objPrimaryContract = [SELECT id,Name,NRD_Equipment_Type__c,NRD_Contract_Type__c,Status,AccountId,NRD_Signer_1__c,NRD_Signer_2__c FROM Contract WHERE Opportunity__c =: objOpportunity.NRD_Amend_Opportunity__c AND Status =: 'Active' LIMIT 1];
        	RecordType objRecordType = [SELECT id FROM RecordType WHERE DeveloperName =: recordTypeName and SobjectType ='Contract'];

        	try{

        		Contract cloneContract = objPrimaryContract.clone(false,false,false,false);
        		cloneContract.RecordTypeId = objRecordType.id;
        		cloneContract.Status = 'Request';
        		cloneContract.Sub_Type__c = 'Amended';
        		cloneContract.Opportunity__c = opportunityId;
        		cloneContract.NRD_Contract_History__c = objPrimaryContract.id;
        		insert cloneContract; 

        		objPrimaryContract.Sub_Type__c = 'Superseded';
        		update objPrimaryContract;

        		Message = 'record Saved successfully !!!!';

        		}Catch(Exception e){
        			Message = 'record failed !!!';
        			system.debug('Exception due to============>'+e.getMessage()+e.getLineNumber());
        		}


        		return Message;


        }
        
        
}