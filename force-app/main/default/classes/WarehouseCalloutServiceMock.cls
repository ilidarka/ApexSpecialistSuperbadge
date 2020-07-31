public class WarehouseCalloutServiceMock implements HTTPCalloutMock {
    // implement http mock callout
    public HTTPResponse respond (HttpRequest request){
        HttpResponse response = new HTTPResponse();
        response.setHeader('Content-type','application/json');
        response.setBody('[{"_id":"11d22223326b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}]');
        response.setStatusCode(200);
        return response;
    } 
}