({
	 setSelected : function(component, event, helper){
        var args = event.getParams().arguments;
        var selected = args.selected;
        component.set("v.selected", selected);
    },

    /* This function will fire an even when the select checkbox is changed */
    selectChange : function(component, event, helper){
        var selected = component.get("v.selected");
        var row = component.get("v.recordData");

        if(selected){
            helper.fireGenericComponentEvent(component, 'GENERIC_EVENT_ROW_SELECTED', [row]);
        }
        else{
            helper.fireGenericComponentEvent(component, 'GENERIC_EVENT_ROW_DESELECTED', [row]);
        }
    },
})