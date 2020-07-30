public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';

    @future(callout = true)
    public static void runWarehouseEquipmentSync() {
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());

            List<Product2> newProducts = new List<Product2>();
            for(Object item : results) {
                Map<String, Object> productsMap = (Map<String, Object>) item;
                Product2 product = new Product2();
                product.ProductCode = (String)productsMap.get('_id');
                product.Cost__c = (Integer)productsMap.get('cost');
                product.Lifespan_Months__c = (Integer)productsMap.get('lifespan');
                product.Maintenance_Cycle__c = (Integer)productsMap.get('maintenanceperiod');
                product.Name = (String)productsMap.get('name');
                product.Current_Inventory__c = (Integer)productsMap.get('quantity');
                product.Replacement_Part__c = (Boolean)productsMap.get('replacement');
                product.Warehouse_SKU__c = (String)productsMap.get('sku');
                newProducts.add(product);
            }

            if(newProducts != null) {
                insert newProducts;
            }
        }        
    }
}