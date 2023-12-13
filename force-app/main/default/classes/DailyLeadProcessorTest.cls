@isTest
private class DailyLeadProcessorTest {
	@testSetup
    static void setup(){
        List<Lead> leadslist = new List<Lead>();
        for(Integer i = 1; i <= 200; i++){
            Lead ld = new Lead(Company = 'Comp' + i ,LastName = 'Last'+i, Status = 'Working - Contacted');
            leadslist.add(ld);
        }
        Insert leadslist;
    }
    @isTest
    static void testDailyLeadProcessorScheduledJob(){
        String sch = '0 5 12 * * ?';
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', sch, new DailyLeadProcessor());
        
        List<Lead> leadslist = [select id from lead where leadsource = null limit 200];
        System.assertEquals(200, leadslist.size());

        Test.stopTest();
    }
}