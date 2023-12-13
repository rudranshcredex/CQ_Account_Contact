@isTest
private class GetProductDataTest {

    @isTest
     private static void testGetProductDataMethod() {
        
        test.setMock(HttpCalloutMock.class, new HttpCalloutForTestClass());
         
		Map<string, object> testSample = GetProductData.GetProductDataMethod();
         
        //system.assertEquals();
    }
}