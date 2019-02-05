({
	doInit : function(component, event, helper) {
		var action = component.get("c.cloneAmendedContract");
        action.setParams({
            "opportunityId" : component.get("v.recordId") 
        });
        action.setCallback(this, function(response){
        	var state = response.getState();
        	if(state == "SUCCESS") {
        		var toastEvent = $A.get("e.force:showToast");
    			toastEvent.setParams({
       				"title": "Success!",
        			"message": "The record has been updated successfully."
    		});
   			toastEvent.fire();
        	}else if(state == "ERROR"){
        		var errors = response.getError();
        		console.log('errors------>',errors);
        	}
        });$A.enqueueAction(action);
	}
})