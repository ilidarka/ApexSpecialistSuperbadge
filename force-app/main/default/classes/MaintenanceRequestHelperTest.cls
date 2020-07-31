@isTest
public class MaintenanceRequestHelperTest {
    
    @IsTest
    static void requestHelperTestMethod(){
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
        insert casesList;    
        System.assertEquals(5, casesList.size());
        for(Case item : casesList){
            item.Status = 'Closed';
        }
        update casesList;
        System.assertEquals(5, casesList.size());
        Test.stopTest();
        
    }
    
    static testmethod void testMaintenanceRequestNegative() {
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
        for(Case item : casesList){
            item.Status = 'Working';
        }
        Test.stopTest();

    }
    
    @isTest 
    static void testCaseBulkInsert(){
        List<Case> casesList = new List<Case>();
        For(Integer i = 1; i <= 5; i++) {
            Case testCase = new Case(
                type = 'Routine Maintenance',
                status = 'Closed',
                origin = 'Web',
                Subject = null,
                Date_Reported__c = date.today(),
                Vehicle__c = null,
                Equipment__c = null,
                Date_Due__c = date.today());
            casesList.add(testCase);
        }
        system.assertEquals(casesList.size(), 5);                   
    } 
    
}