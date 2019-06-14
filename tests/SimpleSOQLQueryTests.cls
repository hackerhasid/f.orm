@isTest
public class SimpleSOQLQueryTests {
  @isTest static void SimpleIncludeTest() {
    Account a = new Account(Name = 'Microsoft');
    insert a;
    Opportunity o = new Opportunity(Name = 'Test Microsoft', AccountId = a.id, StageName = 'Prospecting', CloseDate = Date.today());
    insert o;

    Test.startTest();
    Opportunity op = (Opportunity)
      SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
      .Include('Account')
      .First();

    Test.stopTest();

    System.assertEquals('Microsoft', op.Account.Name);
  }
}
