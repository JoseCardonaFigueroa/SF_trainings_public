public class CompaniesListController {
    
    public class CompanyRecord{
        
        public CompanyRecord(Id companyId,String companyName) {
        	this.companyFields = new List<CompanyField>();
            this.companyId = companyId;
            this.companyName = companyName;
        }
        
        public void addField(CompanyField field){
           this.companyFields.add(field) ;
        }       
        
        @AuraEnabled
        public Id companyId {get; set;} 
        @AuraEnabled
        public String companyName {get; set;} 
        @AuraEnabled
        public List<CompanyField> companyFields {get; set;}
    }
    
    public class CompanyField{
        public CompanyField (Object fieldValue,String fieldName){           
            this.fieldValue= fieldValue;
            this.fieldName= fieldName;
            this.renderAsCustomComponent = false;
        }
        
        public CompanyField (String fieldType,Object fieldValue,String fieldName){
            this.fieldType= fieldType;
            this.fieldValue= fieldValue;
            this.fieldName= fieldName;
            this.renderAsCustomComponent = false;
        }
        
        public CompanyField (Object fieldValue,String fieldName,Boolean renderAsCustomComponent,String componentName){
            this.fieldType= fieldType;
            this.fieldValue= fieldValue;
            this.fieldName= fieldName;
            this.renderAsCustomComponent = renderAsCustomComponent;
            this.componentName= componentName;
        }
        @AuraEnabled
        public String fieldType {get; set;}
        
        @AuraEnabled
        public Object fieldValue {get; set;}
    
        @AuraEnabled
        public String fieldName {get; set;}
        
        @AuraEnabled
        public String componentName {get; set;}
        
        @AuraEnabled
        public Boolean renderAsCustomComponent {get; set;}
        
    }
    
	
    @AuraEnabled
    public static List<CompanyRecord> getCompanyList() {
        List<CompanyRecord> companyList = new List<CompanyRecord>();
        try {
            Integer maxRows= Limits.getLimitQueryRows()- Limits.getQueryRows();
            for(Company__c company : [Select id, Name, Country__c,of_Primary_Employees__c,Number_of_All_Employees__c,Number_of_Primary_Employees__c from Company__c LIMIT :maxRows ]){
                CompanyRecord companyWrapper = new CompanyRecord(company.id,company.Name);
                Map<String, Object> fieldsToValue = company.getPopulatedFieldsAsMap();
                for(String field : fieldsToValue.keySet()){
                    
                    if(field != 'Name' && field != 'Id' ){
                        if(field == 'of_Primary_Employees__c'){
                            companyWrapper.addField(new CompanyField(fieldsToValue.get(field),field,true,'c:ProgressBar'));
                        }else{
                        	companyWrapper.addField(new CompanyField(fieldsToValue.get(field),field)); 
                        }
                    }
                    
                }
                 companyList.add(companyWrapper);
            }
          
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }

        return companyList;
    }
}