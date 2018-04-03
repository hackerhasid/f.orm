@isTest
public class PredicateTests {
  static Account bill;
  static Account steve;
  static {
    bill = new Account( Name = 'Bill Gates', AnnualRevenue = 1);
    steve = new Account( Name = 'Steve Jobs', AnnualRevenue = 2);
    insert bill;
    insert steve;
  }
  @isTest static void SimpleAndPredicate() {
    Lead l1 = new Lead(LastName = 'TestLast', Company = 'Company 1');
    Lead l2 = new Lead(LastName = 'TestLast', Company = 'Company 2');
    insert l1;
    insert l2;

    Test.startTest();
   Lead[] leads = (Lead[])
      SimpleSOQLQuery.newInstance(Lead.SObjectType)
      .Predicate(AndPredicate.newInstance(EqualsPredicate.newInstance('LastName', 'TestLast'), EqualsPredicate.newInstance('Company', 'Company 1')))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, leads.size());
    System.assertEquals('Company 1', leads.get(0).Company);
  }

  @isTest static void SimpleOrPredicate() {
    Lead l1 = new Lead(LastName = 'Good', Company = 'Company 1');
    Lead l2 = new Lead(LastName = 'Bad', Company = 'Company 2');
    Lead l3 = new Lead(LastName = 'Good', Company = 'Company 3');
    insert l1;
    insert l2;
    insert l3;

    Test.startTest();
    Lead[] leads = (Lead[])
      SimpleSOQLQuery.newInstance(Lead.SObjectType)
      .Predicate(OrPredicate.newInstance(EqualsPredicate.newInstance('Company', 'Company 1'), EqualsPredicate.newInstance('Company', 'Company 3')))
      .Execute();

    Test.stopTest();

    System.assertEquals(2, leads.size());
    System.assertEquals('Good', leads.get(0).LastName);
    System.assertEquals('Good', leads.get(1).LastName);
  }

  @isTest static void SimpleEqualsString() {

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(EqualsPredicate.newInstance('Name', 'Bill Gates'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Bill Gates', acts[0].Name);
  }

  @isTest static void SimpleNotEqualsString() {

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('Name', 'Bill Gates'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Steve Jobs', acts[0].Name);
  }

  @isTest static void SimpleLikeString() {

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(LikePredicate.newInstance('Name', 'Bill%'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Bill Gates', acts[0].Name);
  }
  @isTest static void SimpleNotLikeString() {

    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(NotPredicate.newInstance(LikePredicate.newInstance('Name', 'Bill%')))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Steve Jobs', acts[0].Name);
  }
  @isTest static void SimpleGreaterThanOrEqualsPredicate() {
    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(GreaterThanOrEqualsPredicate.newInstance('AnnualRevenue', 1))
      .Execute();
    Test.stopTest();

    System.assertEquals(2, acts.size());
  }
  @isTest static void SimpleGreaterThanPredicate() {
    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(GreaterThanPredicate.newInstance('AnnualRevenue', 1))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Steve Jobs', acts.get(0).Name);
  }

  @isTest static void SimpleLessThanOrEqualsPredicate() {
    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(LessThanOrEqualsPredicate.newInstance('AnnualRevenue', 2))
      .Execute();
    Test.stopTest();

    System.assertEquals(2, acts.size());
  }

  @isTest static void SimpleLessThanPredicate() {
    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(LessThanPredicate.newInstance('AnnualRevenue', 2))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Bill Gates', acts.get(0).Name);
  }

  @isTest static void SimpleInPredicate() {
    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(InPredicate.newInstance('AnnualRevenue', new List<Integer> { 1, 5, 10 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Bill Gates', acts.get(0).Name);
  }

  @isTest static void SimpleNotInPredicate() {
    Test.startTest();
    Account[] acts = (Account[])
      SimpleSOQLQuery.newInstance(Account.SObjectType)
      .Predicate(NotInPredicate.newInstance('AnnualRevenue', new List<Integer> { 1, 5, 10 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, acts.size());
    System.assertEquals('Steve Jobs', acts.get(0).Name);
  }


}
