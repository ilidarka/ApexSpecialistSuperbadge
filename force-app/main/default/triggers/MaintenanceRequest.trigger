trigger MaintenanceRequest on Case (before update, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    List<case> closedCasesList = [SELECT Id, Subject, Vehicle__c, Vehicle__r.Name, Equipment__c, Type 
                                FROM Case 
                                WHERE Status = 'closed'];
    
    if(Trigger.isUpdate  && Trigger.isAfter){
        for(Case c : Trigger.New){
            if(c.Type == 'Repair' || c.Type =='Routine Maintenance'){
                MaintenanceRequestHelper.updateWorkOrders(closedCasesList);
            }
        }
    }
}