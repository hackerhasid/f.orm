@isTest
public class SimpleSOQLQueryTests {
  @isTest static void SimpleEqualsString() {
    // setup
    Account bill = new Account( Name = 'Bill Gates' );
    Account steve = new Account( Name = 'Steve Jobs' );
    insert bill;
    insert steve;

    Test.startTest();
    IPredicate predicate = new SimplePredicate('Name', new EqualsOperator(), 'Bill Gates');
    SimpleSOQLQuery query = new SimpleSoqlQuery(Account.SObjectType);
    query.Predicate(predicate);
    query.SetLimit(1);

    Account act = (Account) query.First();
    Test.stopTest();

    System.assertEquals('Bill Gates', act.Name);
  }
}
