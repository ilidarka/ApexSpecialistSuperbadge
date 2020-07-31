@isTest
private class WarehouseSyncScheduleTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    @isTest
    static void TestScheduleJob(){
        Vehicle__c vc = new Vehicle__c();
        vc.name='Test Vehicle';
        insert vc;
        
        Product2 prod = new Product2();
        prod.Name='Test Product';
        prod.Maintenance_Cycle__c = 1;
        prod.Replacement_Part__c = true;
        insert prod;
        
        List<Case> casesList = new List<Case>();
        for(Integer i = 0; i < 5; i++){
            Case newCase = new Case();
            if(math.mod(i, 2) == 0) {
                newCase.Type='Routine Maintenance';
            } else {
                newCase.Type='Repair';
            }
            newCase.Status='New';
            newCase.Vehicle__c = vc.Id;
            newCase.Subject='Routine Maintenance of Vehicle' + i;
            newCase.Origin='web';
            newCase.Date_Reported__c = Date.today();
            newCase.Date_Due__c = Date.today();
            newCase.Equipment__c = prod.Id;
            casesList.add(newCase);
        }

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String joBID= System.schedule('TestScheduleJob', CRON_EXP, new WarehouseSyncSchedule());
        Test.stopTest();
    }
}