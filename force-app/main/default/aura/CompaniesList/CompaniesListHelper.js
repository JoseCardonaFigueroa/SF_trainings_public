({
	doInit: function(component, event, helper) {        
        var action = component.get('c.getCompanyList');
        action.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                var companyList = response.getReturnValue();
                component.set('v.companyRecords', companyList);
                console.log('v.companyRecords: ' + companyList);
            } else {
                console.log('error in apex callback (i.e. getAllCompanies)' + response.getError());
            }
        });
        $A.enqueueAction(action);
	}
})