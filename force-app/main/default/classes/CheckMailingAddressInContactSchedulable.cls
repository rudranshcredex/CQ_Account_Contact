public class CheckMailingAddressInContactSchedulable implements Schedulable {
  public void execute(SchedulableContext context) {
    
    CheckMailingAddressInContact batch = new CheckMailingAddressInContact();
    Database.executeBatch(batch);
      
 

  }
}