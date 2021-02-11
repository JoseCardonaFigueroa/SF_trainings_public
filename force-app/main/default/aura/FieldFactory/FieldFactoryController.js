({
	doInit : function(component, event, helper) {
        let field = component.get('v.field');
        if(field){
           helper.createField(component, event, helper,field) 
        }		
	}
})