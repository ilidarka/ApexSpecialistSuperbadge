public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<case> closedCasesList) {
        // TODO: Complete the method to update workorders
        list<case> insertCasesList = new list<case>();
        
        for(Case c : closedCasesList) {
            if(c.status=='Closed') {
                if(c.type=='Repair' || c.type=='Routine Maintenance'){
                    Case newCase = new Case();
                    newCase.Type = 'Routine Maintenance';
                    newCase.Status = 'New';
                    newCase.Vehicle__c = c.Vehicle__c;
                    newCase.Subject =  c.Subject;
                    newCase.Date_Reported__c = System.today();
                    newCase.Date_Due__c = System.today();
                    newCase.Equipment__c = c.Equipment__c;
                    insertCasesList.add(newCase);
                }
            }
        }
        if(insertCasesList.size() > 0 && insertCasesList.size() != null){
            insert insertCasesList;
        }
    }
}