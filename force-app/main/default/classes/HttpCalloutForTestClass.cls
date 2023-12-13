global class HttpCalloutForTestClass implements HttpCalloutMock {
    global httpResponse respond(HTTPRequest req){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"products": [{"id": 1, "title": "Product 1", "price": 10}, {"id": 2, "title": "Product 2", "price": 20}]}');
        response.setStatusCode(200);
        return response;
    }
}