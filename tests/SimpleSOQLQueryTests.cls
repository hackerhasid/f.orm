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

  @isTest static void OrderAndOffset() {
    Account a1 = new Account(Name = 'B');
    insert a1; 
    Account a2 = new Account(Name = 'A');
    insert a2; 
    Account a3 = new Account(Name = 'C');
    insert a3;

    Test.startTest();
    Account[] accts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .OrderBy(OrderBy.NewInstance().ByField('Name', OrderBy.OrderDirection.DESCENDING))
      .SetOffset(1)
      .Execute();
    Test.stopTest();

    System.assertEquals(2, accts.size());
    System.assertEquals('B', accts.get(0).Name);
    System.assertEquals('A', accts.get(1).Name);
  }
}
