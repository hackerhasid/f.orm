@isTest
public class PredicateTests {
  @isTest static void SimpleEqualsString() {
    // setup
    Account bill = new Account( Name = 'Bill Gates' );
    Account steve = new Account( Name = 'Steve Jobs' );
    insert bill;
    insert steve;

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .SetLimit(1)
      .Predicate(EqualsPredicate.newInstance('Name', 'Bill Gates'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Bill Gates', acts[0].Name);
  }

  @isTest static void SimpleNotEqualsString() {
    // setup
    Account bill = new Account( Name = 'Bill Gates' );
    Account steve = new Account( Name = 'Steve Jobs' );
    insert bill;
    insert steve;

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .SetLimit(1)
      .Predicate(NotEqualsPredicate.newInstance('Name', 'Bill Gates'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Steve Jobs', acts[0].Name);
  }

  @isTest static void SimpleLikeString() {
    // setup
    Account bill = new Account( Name = 'Bill Gates' );
    Account steve = new Account( Name = 'Steve Jobs' );
    insert bill;
    insert steve;

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .SetLimit(1)
      .Predicate(LikePredicate.newInstance('Name', 'Bill%'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Bill Gates', acts[0].Name);
  }
  @isTest static void SimpleNotLikeString() {
    // setup
    Account bill = new Account( Name = 'Bill Gates' );
    Account steve = new Account( Name = 'Steve Jobs' );
    insert bill;
    insert steve;

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .SetLimit(1)
      .Predicate(NotPredicate.newInstance(LikePredicate.newInstance('Name', 'Bill%')))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Steve Jobs', acts[0].Name);
  }
}
