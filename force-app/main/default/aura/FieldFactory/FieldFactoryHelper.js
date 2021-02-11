({
	getComponentSpec :function(component, event , helper, field) {
		switch (field.renderAsCustomComponent) {
             case true:        return helper.createGenericField(component, event , helper, field); break;     			                 
             default:          return helper.createStandardField(component, event , helper, field); break;   
        }
	},
    
    createField:function(component, event , helper, field) {
    	let  componentSpec = helper.getComponentSpec(component, event , helper, field);
        if(componentSpec){
            $A.createComponent(componentSpec.name, componentSpec.attributes, function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {              
    				var body = component.get('v.body');
                    body.push(newComponent);
                    component.set('v.body', body);
                }else{
                    console.log(errorMessage);
                }
            });   
        }
		 
	},
    
    createStandardField: function (component, event , helper, field) {
        return {
            name: 'lightning:inputField',
            attributes: {
                value: field.fieldValue,
                fieldName: field.fieldName,
                readonly: true
            }
        }
    },
    
    createGenericField: function (component, event , helper, field) {
        return {
            name: field.componentName,
            attributes: {
                value: field.fieldValue,
                fieldName: field.fieldName,
                title: field.fieldName
            }
        }
    },
    
  
})