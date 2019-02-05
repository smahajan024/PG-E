({
	
	handleChange : function(component, event, helper) {
		 var selectedValue = component.find("makeId").get("v.value");
    	 var action = component.get("c.cloneAmendedOpportunity");
    	 action.setParams({
    	 	"objectId" : component.get("v.recordId");
    	 	"processValue": component.find("makeId").get("v.value");; 
    	 });

    	 action.setCallback(this, function(response){
    	 	if (response.getState() === "SUCCESS") {
                var result = response.getReturnValue();                
                /*$A.get("e.force:closeQuickAction").fire()                
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "",
                        "type": "SUCCESS",
                        "message": result,
                        "duration": "1000"
                    });
                    toastEvent.fire();                                    
                $A.get('e.force:refreshView').fire(); 
            }*/
           }

    	 });
    	 $A.enqueueAction(action);
	}
})