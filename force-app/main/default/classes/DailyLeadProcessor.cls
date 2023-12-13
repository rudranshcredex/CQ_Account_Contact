public class DailyLeadProcessor implements schedulable {
    public static void execute(SchedulableContext context){
        list<lead> leads = new list<lead>();
        list<lead> leadsList = new list<lead>([select id from lead where leadsource = null limit 200]);
        for(lead l : leadslist){
            l.leadsource = 'Dreamforce';
            leads.add(l);
        }
        update leads;
    }
	
}