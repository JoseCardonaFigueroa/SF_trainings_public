({
	 fireGenericComponentEvent: function(component, state, data) {        
         var event = component.getEvent('genericComponentEvent');     
         event.setParams({
             "sourceLocalId": component.getLocalId(),
             "sourceGlobalId": component.getGlobalId(),
             "source": 'AbstractRecordView',
             "state": state,
             "data": data
         })
         .fire();
     },
})