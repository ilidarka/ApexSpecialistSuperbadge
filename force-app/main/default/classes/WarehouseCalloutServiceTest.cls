@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
    @isTest  
    static void testWareHouseCallout(){
        Test.startTest();
        Test.setMock(HTTPCalloutMock.class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
    }  
}